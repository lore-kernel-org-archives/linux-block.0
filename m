Return-Path: <SRS0=BJAb=24=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4F0C33C99
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 08:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED09206DB
	for <linux-block@archiver.kernel.org>; Tue,  7 Jan 2020 08:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Na+1tm1P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbgAGItO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 03:49:14 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:58696 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgAGItN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 03:49:13 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0078hUC0093414;
        Tue, 7 Jan 2020 08:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2019-08-05;
 bh=pg1w4l5lmMFappxkKDoFEKH5iKsiM0ufnEC9QtBIhnI=;
 b=Na+1tm1PB48mvJEsQlozQtNiyPN8NERhMGLUsfZnQwrLS5QVA0GW9N7r+mXoqWCKMu8P
 rtdt0JxgBQ3no8vZmAYuGfwQZ5iIIesjuy+3ksBmPM3xPGymFW7oI29Ur2rfyKm1Zk0B
 5ycgUN9in4UcK8oEGb60+Sump5mx1JlDLO3H5P5BWWX4FiYXGVIV/k0r58aXAGG9ITp+
 iRMglRWgFgJlGdj3NAbNJZtn8oR9hIsv9ui9PYx6aGYkzcb/NxJCo8uSCzhBu4TuVjMz
 VqiA+ExgWXJbEtD9uZoitdQH1tzMHexthd8DtWEqgVHu7KxeeJRiLYe2n3i541iYMrF1 LQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2xaj4tv36k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 08:49:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 0078irvX125305;
        Tue, 7 Jan 2020 08:47:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2xb47k1tvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 07 Jan 2020 08:47:08 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0078l7ZO021515;
        Tue, 7 Jan 2020 08:47:07 GMT
Received: from kili.mountain (/129.205.23.165)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 07 Jan 2020 00:47:06 -0800
Date:   Tue, 7 Jan 2020 11:46:59 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     arnd@arndb.de
Cc:     linux-block@vger.kernel.org
Subject: [bug report] compat_ioctl: move CDROM_SEND_PACKET handling into scsi
Message-ID: <20200107084659.uyaucu73yd5rhim3@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=713
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001070070
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9492 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=766 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001070070
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Arnd Bergmann,

The patch f3ee6e63a9df: "compat_ioctl: move CDROM_SEND_PACKET
handling into scsi" from Nov 28, 2019, leads to the following static
checker warning:

	block/scsi_ioctl.c:703 scsi_put_cdrom_generic_arg()
	warn: check that 'cgc32' doesn't leak information (struct has a hole after 'data_direction')

block/scsi_ioctl.c
   686  static int scsi_put_cdrom_generic_arg(const struct cdrom_generic_command *cgc,
   687                                        void __user *arg)
   688  {
   689  #ifdef CONFIG_COMPAT
   690          if (in_compat_syscall()) {
   691                  struct compat_cdrom_generic_command cgc32 = {
   692                          .buffer         = (uintptr_t)(cgc->buffer),
   693                          .buflen         = cgc->buflen,
   694                          .stat           = cgc->stat,
   695                          .sense          = (uintptr_t)(cgc->sense),
   696                          .data_direction = cgc->data_direction,
   697                          .quiet          = cgc->quiet,
   698                          .timeout        = cgc->timeout,
   699                          .reserved[0]    = (uintptr_t)(cgc->reserved[0]),
   700                  };

It's possible that initializations like this don't clear out the struct
hole but I haven't seen a compiler which is affected.  So maybe it's
fine?

   701                  memcpy(&cgc32.cmd, &cgc->cmd, CDROM_PACKET_SIZE);
   702  
   703                  if (copy_to_user(arg, &cgc32, sizeof(cgc32)))
   704                          return -EFAULT;
   705  
   706                  return 0;
   707          }
   708  #endif
   709          if (copy_to_user(arg, cgc, sizeof(*cgc)))
   710                  return -EFAULT;
   711  
   712          return 0;
   713  }

See also:
drivers/media/v4l2-core/v4l2-ioctl.c:3140 video_put_user() warn: check that 'ev32' doesn't leak information (struct has a hole after 'type')
drivers/media/v4l2-core/v4l2-ioctl.c:3165 video_put_user() warn: check that 'vb32' doesn't leak information (struct has a hole after 'memory')

regards,
dan carpenter
