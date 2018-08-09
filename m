Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:7894 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727417AbeHIIiL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 04:38:11 -0400
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
        by mx0a-00154901.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w796DN9P153970
        for <linux-block@vger.kernel.org>; Thu, 9 Aug 2018 02:14:55 -0400
Received: from esa4.dell-outbound2.iphmx.com (esa4.dell-outbound2.iphmx.com [68.232.154.98])
        by mx0a-00154901.pphosted.com with ESMTP id 2kr273v29a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-block@vger.kernel.org>; Thu, 09 Aug 2018 02:14:55 -0400
From: "Singh, Sarabjeet" <Sarabjeet.Singh2@Dell.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: "sarab.1509@gmail.com" <sarab.1509@gmail.com>
Subject: "block_device" structure removed from "bio"
Date: Thu, 9 Aug 2018 06:14:37 +0000
Message-ID: <BF34EB2EC9870F4188F7F2256D23AE29E90179@MX301CL02.corp.emc.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

Greetings..!!

I'd like to report an issue which I've been facing in the new kernels (from=
 4.14 and newer).

Till kernel 4.13, we had the block_device structure as part of=20

struct bio {
       struct bio           *bi_next;     /* request queue link */
       struct block_device *bi_bdev;
       unsigned int         bi_flags;     /* status, command, etc */
       int                  bi_error;
       unsigned long        bi_rw;        /* bottom bits READ/WRITE,
                                          * top bits priority
                                          */

>From kernel 4.14 onwards, this has been removed and I'm facing this error:
Error: "struct bio" has no member named "bi_bdev"

Code block (which gives this error):

dev_t block_device =3D bio->bi_bdev->bd_dev

As part of the driver code, I need to retrieve the "block_device" from the =
"bio" structure.
As per my understanding there is no existing API to do the same. Can you pl=
ease let me know if there is any such API? If not, then can I expect any fi=
x for the same in the future?

Regards,
Sarabjeet
