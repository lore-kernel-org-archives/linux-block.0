Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:38061 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727541AbeHFRRM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Aug 2018 13:17:12 -0400
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v4 07/10] block, scsi: Rework runtime power management
Date: Mon, 6 Aug 2018 15:07:34 +0000
Message-ID: <19eea64ff3109f8e13d56094f45cf1e69a3679e9.camel@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
         <20180804000325.3610-8-bart.vanassche@wdc.com>
         <c92dffc6-c7e6-c040-00db-6f42e51618fb@oracle.com>
In-Reply-To: <c92dffc6-c7e6-c040-00db-6f42e51618fb@oracle.com>
Content-Type: text/plain; charset="utf-7"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, 2018-08-06 at 10:46 +-0800, jianchao.wang wrote:
+AD4- On 08/04/2018 08:03 AM, Bart Van Assche wrote:
+AD4- +AD4- Instead of allowing requests that are not power management requ=
ests
+AD4- +AD4- to enter the queue in runtime suspended status (RPM+AF8-SUSPEND=
ED), make
+AD4- +AD4- the blk+AF8-get+AF8-request() caller block.=20
+AD4-=20
+AD4- Who will resume the runtime suspended device ?
+AD4-=20
+AD4- In original blk-legacy, when a request is added, blk+AF8-pm+AF8-add+A=
F8-request will call
+AD4- pm+AF8-request+AF8-resume could do that. The request will be issued a=
fter the q is resumed
+AD4- successfully.
+AD4-=20
+AD4- After this patch, non-pm request will be blocked and pm+AF8-request+A=
F8-resume is removed from
+AD4- blk+AF8-pm+AF8-add+AF8-request, who does resume the runtime suspended=
 q and device ?

Hello Jianchao,

I will double check that all contexts from which requests are submitted
protect submission of non-RQF+AF8-PM requests with scsi+AF8-autopm+AF8-get+=
AF8-device() /
scsi+AF8-autopm+AF8-put+AF8-device(). scsi+AF8-autopm+AF8-get+AF8-device() =
namely resumes suspended
devices.

Bart.
