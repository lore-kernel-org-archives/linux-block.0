Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f173.google.com ([209.85.216.173]:35460 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751546AbdFOWKZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Jun 2017 18:10:25 -0400
Received: by mail-qt0-f173.google.com with SMTP id w1so39224319qtg.2
        for <linux-block@vger.kernel.org>; Thu, 15 Jun 2017 15:10:25 -0700 (PDT)
To: GNU C Library <libc-alpha@sourceware.org>,
        Christoph Hellwig <hch@infradead.org>
Cc: Stephen Bates <sbates@raithlin.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@fb.com>
From: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Subject: RFC: pwritev2 regression test for invalid flags
Message-ID: <a5987ece-5351-346b-21fd-5a3e0092229e@linaro.org>
Date: Thu, 15 Jun 2017 19:10:18 -0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

After the issue with LO_HI_LONG definition on x86_64-linux-gnu, I planed to add 
this patch to check the above patch for correct check for invalid flags (which
would also have show this issue with LO_HI_LONG being used on p{read,write}v2).

However it seems to trigger what I think it is a kernel bug on version that
provides p{read,write}v, where preadv2 does fails with EOPNOTSUPP but
pwritev2 does not.  For instance, on x86_64-linux-gnu-x32 and i686-linux-gnu
(4.10.0-21-generic/x86_64):

[...]
[pid  1027] preadv2(3, 0xff96d3d0, 1, 0, 0x8 /* RWF_??? */) = -1 EOPNOTSUPP (Operation not supported)
[pid  1027] pwritev2(3, [{"\0\360bVl\206\4\10\0\0\0\0Z=l\367t\372\226\377\214\362`\367\f\0\0\0\0\320\4\10", 32}], 1, 0, 0x8 /* RWF_??? */) = 32
[...]

And on sparcv9-linux-gnu (4.12.0-rc1-sparc64-smp):

[...]
[pid 139846] preadv2(3, [{iov_base=0xffefcd88, iov_len=32}], 1, 0, 0x8 /* RWF_??? */) = -1 EOPNOTSUPP (Operation not supported)
[pid 139846] pwritev2(3, [{iov_base="\377\357\315\300p\1f\314\0\0\0\0\0\0\0\2p\3@\10\0\2B\260p\3+\330\0\1\21\220", iov_len=32}], 1, 0, 0x8 /* RWF_??? */) = 32
[...]

For both on 64 bits syscalls works as intended. For instance on x86-64
aforementioned kernel:

[...]
[pid 24276] preadv2(3, 0x7ffd084c1ee0, 1, 0, 0x8 /* RWF_??? */) = -1 EOPNOTSUPP (Operation not supported)
[pid 24276] pwritev2(3, [{"\0\0\0\0\0\0\0\0!`\331\311\304\177\0\0\220\37L\10\375\177\0\0\0\0\0\0\0\0\0\0", 32}], 1, 0, 0x8 /* RWF_??? */) = -1 EOPNOTSUPP (Operation not supported)
[...]

I haven't tested on newer kernels or on different architectures (these
are the ones I have readily available). Any idea why kernel ignores invalid
flags for pwritev2 on compatibility mode? Does it invalidate the testcase?

PS: I am copying the ones on the original pwritev2/preadv2 email about the
status of the syscall on glibc [1].

[1] https://sourceware.org/ml/libc-alpha/2017-04/msg00452.html

--

diff --git a/misc/tst-preadvwritev2-common.c b/misc/tst-preadvwritev2-common.c
new file mode 100644
index 0000000000..a8073e6894
--- /dev/null
+++ b/misc/tst-preadvwritev2-common.c
@@ -0,0 +1,46 @@
+/* Common function for preadv2 and pwritev2 tests.
+   Copyright (C) 2017 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, see
+   <http://www.gnu.org/licenses/>.  */
+
+#include <support/check.h>
+
+static void
+do_test_with_invalid_flags (void)
+{
+  int invalid_flag = 0x1;
+#ifdef RWF_HIPRI
+  invalid_flag <<= 1;
+#endif
+#ifdef RWF_DSYNC
+  invalid_flag <<= 1;
+#endif
+#ifdef RWF_SYNC
+  invalid_flag <<= 1;
+#endif
+
+  char buf[32];
+  const struct iovec vec = { .iov_base = buf, .iov_len = sizeof (buf) };
+  if (preadv2 (temp_fd, &vec, 1, 0, invalid_flag) != -1)
+    FAIL_EXIT1 ("preadv2 did not fail with an invalid flag");
+  if (errno != ENOTSUP)
+    FAIL_EXIT1 ("preadv2 failure did not set errno to ENOTSUP (%d)", errno);
+
+  if (pwritev2 (temp_fd, &vec, 1, 0, invalid_flag) != -1)
+    FAIL_EXIT1 ("pwritev2 did not fail with an invalid flag");
+  if (errno != ENOTSUP)
+    FAIL_EXIT1 ("pwritev2 failure did not set errno to ENOTSUP (%d)", errno);
+}
diff --git a/misc/tst-preadvwritev2.c b/misc/tst-preadvwritev2.c
index cf36272dd3..682c7579da 100644
--- a/misc/tst-preadvwritev2.c
+++ b/misc/tst-preadvwritev2.c
@@ -23,9 +23,12 @@
   pwritev2 (__fd, __iov, __iovcnt, __offset, 0)
 
 #include "tst-preadvwritev-common.c"
+#include "tst-preadvwritev2-common.c"
 
 static int
 do_test (void)
 {
+  do_test_with_invalid_flags ();
+
   return do_test_with_offset (0);
 }
diff --git a/misc/tst-preadvwritev64v2.c b/misc/tst-preadvwritev64v2.c
index 8d0c48ea78..9ddc7625f0 100644
--- a/misc/tst-preadvwritev64v2.c
+++ b/misc/tst-preadvwritev64v2.c
@@ -25,9 +25,12 @@
   pwritev2 (__fd, __iov, __iovcnt, __offset, 0)
 
 #include "tst-preadvwritev-common.c"
+#include "tst-preadvwritev2-common.c"
 
 static int
 do_test (void)
 {
+  do_test_with_invalid_flags ();
+
   return do_test_with_offset (0);
 }
