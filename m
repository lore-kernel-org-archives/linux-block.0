Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23319 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750732AbdDJUgK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2017 16:36:10 -0400
Subject: Re: [PATCH v4] lightnvm: pblk
To: =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <jg@lightnvm.io>,
        "mb@lightnvm.io" <mb@lightnvm.io>
References: <1491849399-12798-1-git-send-email-javier@cnexlabs.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Javier_Gonz=c3=a1lez?= <javier@cnexlabs.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <ffcc53b3-2b60-dad4-4372-da5b190e6c6e@sandisk.com>
Date: Mon, 10 Apr 2017 13:35:58 -0700
MIME-Version: 1.0
In-Reply-To: <1491849399-12798-1-git-send-email-javier@cnexlabs.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/10/2017 11:36 AM, Javier González wrote:
> Changes since v3:
> * Apply Bart's feedback [1]

Thanks for having addressed these comments. But please also make sure
that the pblk driver builds cleanly with W=1 C=2. When running "make
M=drivers/lightnvm W=1 C=2" several warnings are reported that should be
reviewed. At least the endianness warnings should be addressed. An example:

  CHECK   drivers/lightnvm/pblk-gc.c
drivers/lightnvm/pblk-gc.c:254:18: warning: incorrect type in assignment
(different base types)
drivers/lightnvm/pblk-gc.c:254:18:    expected unsigned long long
[usertype] *lba_list
drivers/lightnvm/pblk-gc.c:254:18:    got restricted __le64 [usertype] *

Please also review the warnings reported by smatch (make
M=drivers/lightnvm C=2 CHECK="smatch -p=kernel"). A few examples that
most likely indicate bugs:

  CHECK   drivers/lightnvm/pblk-init.c
drivers/lightnvm/pblk-init.c:915: pblk_init() error: passing non
negative 1 to ERR_PTR
drivers/lightnvm/pblk-rb.c:782: pblk_rb_tear_down_check() error: we
previously assumed 'rb->entries' could be null (see line 778)  CHECK
drivers/lightnvm/pblk-read.c
drivers/lightnvm/pblk-read.c:486: pblk_submit_read_gc() error: 'bio'
dereferencing possible ERR_PTR()

Thanks,

Bart.
