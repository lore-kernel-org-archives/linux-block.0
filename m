Return-Path: <SRS0=rKNO=6Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F33C54E8D
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 13:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 134AD206F5
	for <linux-block@archiver.kernel.org>; Mon, 11 May 2020 13:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYbJbgPu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbgEKNxJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 May 2020 09:53:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:42142 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgEKNxH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 May 2020 09:53:07 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BDWknA076131;
        Mon, 11 May 2020 13:53:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=FtM+gMxLTOLf0lKicDrEd2XZcK5uSSAqMnINaDIJG7A=;
 b=VYbJbgPu9Emlcp83x4XqBnNj4FNHwDgArI9/mxl58Q4wka/TqY13pgRXvEYFlPTEkD3u
 22PwikKKaqsTa0tkbEZ8DFFD5fk28XsBgF8gLzsgucrzICukyb4iSuRuOdaI77uBQODB
 LeiyrA3QRASi1IOMUMs2ubwcUrlG4LZAi4NJSkE+jMBtwx5NOTEW8Vv2VpJ0+70qlekc
 7YZQQFDUDKw9gcFbxcPBkO7KIja2MQO3ijsMtBUCzK5ORYltfI1oKm604x+uAauN3dVV
 ++4sOMuqCCT8bfemAb6F9lSR+vdMXFnvWIFSTJML/aKsNy2FmJCgOr6a72T3KFi92wNd Yg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 30x3gmd6sb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 May 2020 13:53:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04BDYDwu090002;
        Mon, 11 May 2020 13:51:05 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 30x69r24gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 May 2020 13:51:04 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04BDp30S005428;
        Mon, 11 May 2020 13:51:03 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 11 May 2020 06:51:03 -0700
Date:   Mon, 11 May 2020 16:50:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     javier@javigon.com
Cc:     linux-block@vger.kernel.org
Subject: [bug report] lightnvm: pblk: return NVM_ error on failed submission
Message-ID: <20200511135058.GA216886@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=3 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005110112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 clxscore=1011 spamscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 suspectscore=3
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005110112
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Javier González,

The patch b6730dd4a954: "lightnvm: pblk: return NVM_ error on failed
submission" from Jun 1, 2018, leads to the following static checker
warning:

	drivers/lightnvm/pblk-recovery.c:473 pblk_recov_scan_oob()
	warn: 'pblk->inflight_io.counter' not decremented on lines: 426.

drivers/lightnvm/pblk-recovery.c
   417  
   418                  for (j = 0; j < pblk->min_write_pgs; j++, i++)
   419                          ppa_list[i] =
   420                                  addr_to_gen_ppa(pblk, paddr + j, line->id);
   421          }
   422  
   423          ret = pblk_submit_io_sync(pblk, rqd, data);
   424          if (ret) {
   425                  pblk_err(pblk, "I/O submission failed: %d\n", ret);
   426                  return ret;

The pblk_submit_io_sync() increments the pblk->inflight_io counter but
doesn't decrement it on all error paths.  It looks like something a
little bit subtle is going no but I'm not sure how it works exactly.

   427          }
   428  
   429          atomic_dec(&pblk->inflight_io);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

   430  
   431          /* If a read fails, do a best effort by padding the line and retrying */
   432          if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
   433                  int pad_distance, ret;
   434  
   435                  if (padded) {
   436                          pblk_log_read_err(pblk, rqd);
   437                          return -EINTR;
   438                  }
   439  

regards,
dan carpenter
