Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:30212 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389268AbeG0VNW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 17:13:22 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "colyli@suse.de" <colyli@suse.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
CC: "noah.massey@gmail.com" <noah.massey@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 8/9] bcache: initiate bcache_debug to NULL
Date: Fri, 27 Jul 2018 19:49:55 +0000
Message-ID: <3b4872e3ee954b6e0e81c0750a363df2fdbdd691.camel@wdc.com>
References: <20180726142239.44669-1-colyli@suse.de>
         <20180726142239.44669-9-colyli@suse.de>
In-Reply-To: <20180726142239.44669-9-colyli@suse.de>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, 2018-07-26 at 22:22 +-0800, Coly Li wrote:
+AD4- Global variable bcache+AF8-debug is firstly initialized in bch+AF8-de=
bug+AF8-init(),
+AD4- and destroyed in bch+AF8-debug+AF8-exit(). bch+AF8-debug+AF8-init() i=
s called in
+AD4- bcache+AF8-init() with many other functions, if one of the previous c=
alling
+AD4- onces failed, bcache+AF8-exit() will be called in the failure path.
+AD4-=20
+AD4- The problem is, if bcache+AF8-init() fails before bch+AF8-debug+AF8-i=
nit() is called,
+AD4- then in bcache+AF8-exit() when bch+AF8-debug+AF8-exit() is called to =
destroy global
+AD4- variable bcache+AF8-debug, at this moment bcache+AF8-debug is unndefi=
ned, then the
+AD4- test of +ACI-if (+ACE-IS+AF8-ERR+AF8-OR+AF8-NULL(bcache+AF8-debug))+A=
CI- might be buggy.
+AD4-=20
+AD4- This patch initializes global varabile bcache+AF8-debug to be NULL, t=
o make
+AD4- the failure code path to be predictable.
+AD4-=20
+AD4- Signed-off-by: Coly Li +ADw-colyli+AEA-suse.de+AD4-
+AD4- ---
+AD4-  drivers/md/bcache/debug.c +AHw- 2 +--
+AD4-  1 file changed, 1 insertion(+-), 1 deletion(-)
+AD4-=20
+AD4- diff --git a/drivers/md/bcache/debug.c b/drivers/md/bcache/debug.c
+AD4- index 57f8f5aeee55..24b0eb65ddec 100644
+AD4- --- a/drivers/md/bcache/debug.c
+AD4- +-+-+- b/drivers/md/bcache/debug.c
+AD4- +AEAAQA- -17,7 +-17,7 +AEAAQA-
+AD4-  +ACM-include +ADw-linux/random.h+AD4-
+AD4-  +ACM-include +ADw-linux/seq+AF8-file.h+AD4-
+AD4- =20
+AD4- -struct dentry +ACo-bcache+AF8-debug+ADs-
+AD4- +-struct dentry +ACo-bcache+AF8-debug +AD0- NULL+ADs-
+AD4- =20
+AD4-  +ACM-ifdef CONFIG+AF8-BCACHE+AF8-DEBUG

Please verify patches with checkpatch before posting these. Checkpatch is n=
amely
able to detect that this patch is useless:

+ACQ- scripts/checkpatch.pl +AFwAWw-PATCH+AF8-8+AF8-9+AFwAXQBf-bcache+AFw-:=
+AF8-initiate+AF8-bcache+AF8-debug+AF8-to+AF8-NULL.mbox=20
ERROR: do not initialise globals to NULL
+ACM-217: FILE: drivers/md/bcache/debug.c:20:
+-struct dentry +ACo-bcache+AF8-debug +AD0- NULL+ADs-

Bart.
