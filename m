Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f67.google.com ([209.85.160.67]:32990 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbeGJT5k (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Jul 2018 15:57:40 -0400
Received: by mail-pl0-f67.google.com with SMTP id 6-v6so8076234plb.0
        for <linux-block@vger.kernel.org>; Tue, 10 Jul 2018 12:57:06 -0700 (PDT)
Date: Tue, 10 Jul 2018 12:57:03 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests v3 0/6] Add SRP initiator driver tests
Message-ID: <20180710195703.GA16252@vader>
References: <20180709225643.10537-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180709225643.10537-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jul 09, 2018 at 03:56:37PM -0700, Bart Van Assche wrote:
> Hello Omar,
> 
> As promised during LSF/MM, I have converted the srp-tests software to the
> blktests framework. Please consider this patch series for inclusion in the
> official blktests repository. This patch series is also available as a
> github pull request, namely https://github.com/osandov/blktests/pull/24.
> 
> Thanks,
> 
> Bart.

Awesome!

$ sudo ./check srp
srp/001 (Create and remove LUNs)                             [passed]
runtime  2.260s  ...  1.902s
srp/002 (File I/O on top of multipath concurrently with logout and login (mq)) [passed]
runtime  39.992s  ...  38.689s
srp/003 (File I/O on top of multipath concurrently with logout and login (sq)) [passed]
runtime  10.071s  ...  34.998s
srp/004 (File I/O on top of multipath concurrently with logout and login (sq-on-mq)) [passed]
runtime  10.077s  ...  35.385s
srp/005 (Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M) [passed]
runtime  10.093s  ...  14.184s
srp/006 (Direct I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M) [passed]
runtime  10.171s  ...  12.890s
srp/007 (Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=4M) [passed]
runtime  9.949s  ...  14.197s
srp/008 (Direct I/O with large transfer sizes, cmd_sg_entries=1 and bs=8M) [passed]
runtime  10.029s  ...  12.751s
srp/009 (Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=4M) [passed]
runtime  11.805s  ...  14.138s
srp/010 (Buffered I/O with large transfer sizes, cmd_sg_entries=255 and bs=8M) [passed]
runtime  10.267s  ...  13.941s
srp/011 (Block I/O on top of multipath concurrently with logout and login) [passed]
runtime  11.087s  ...  33.344s
srp/012 (dm-mpath on top of multiple I/O schedulers)         [passed]
runtime  10.141s  ...  10.954s
srp/013 (Direct I/O using a discontiguous buffer)            [passed]
runtime  10.161s  ...  3.721s

As a further improvement, is it possible to configure multipathd to read
from a custom configuration path? That way we could, e.g., dump the
required multipath.conf in $TMPDIR instead of requiring the system-level
configuration.

If not, can you please make the group_requires automatically make the
symlink instead of requiring it? Obviously checking if there was already
a prod config file there.

I also had to apply the following patch:

diff --git a/tests/srp/002 b/tests/srp/002
index c07e76f..74c5fee 100755
--- a/tests/srp/002
+++ b/tests/srp/002
@@ -45,6 +45,7 @@ test_disconnect_repeatedly() {
 }
 
 test() {
+	: "${TIMEOUT:=30}"
 	trap 'trap "" EXIT; teardown' EXIT
 	setup && test_disconnect_repeatedly && echo Passed
 }
diff --git a/tests/srp/003 b/tests/srp/003
index fc85e29..9b8eeb4 100755
--- a/tests/srp/003
+++ b/tests/srp/003
@@ -45,6 +45,7 @@ test_disconnect_repeatedly() {
 }
 
 test() {
+	: "${TIMEOUT:=30}"
 	trap 'trap "" EXIT; teardown' EXIT
 	setup && test_disconnect_repeatedly && echo Passed
 }
diff --git a/tests/srp/004 b/tests/srp/004
index 9c37fd2..1e8766a 100755
--- a/tests/srp/004
+++ b/tests/srp/004
@@ -45,6 +45,7 @@ test_disconnect_repeatedly() {
 }
 
 test() {
+	: "${TIMEOUT:=30}"
 	trap 'trap "" EXIT; teardown' EXIT
 	setup && test_disconnect_repeatedly && echo Passed
 }
diff --git a/tests/srp/011 b/tests/srp/011
index 3561662..df99da5 100755
--- a/tests/srp/011
+++ b/tests/srp/011
@@ -41,6 +41,7 @@ test_disconnect_repeatedly() {
 }
 
 test() {
+	: "${TIMEOUT:=30}"
 	trap 'trap "" EXIT; teardown' EXIT
 	setup && test_disconnect_repeatedly && echo Passed
 }
 
Thanks, Bart!
