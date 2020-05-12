Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC61C54E4A
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 11:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145F320675
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 11:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wrkD+sxi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729459AbgELL3q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 07:29:46 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:32932 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbgELL3q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 07:29:46 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CBRh67089068;
        Tue, 12 May 2020 11:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2020-01-29;
 bh=ed+pKYBNJp9+4qzB+TxV2zN8WsPsAXnGVqs0RIQ/A1Y=;
 b=wrkD+sxiTH5K1QgidLkC5hAM0uRmg+vT6bL/8D0aVNqDp9JrkeVf3w3DVvC5f2aQPbUd
 S967aQKyAUNUxBh0ysm9XXFC4FTQ8l8lrXocvaSMb9yZuyD4OFB8jMCpuJCWviFA7IFj
 SE1jeZ1k2XPOy96ECw3vcz39YoSaNK6rAroOZjIOMTJSjU94lXctGSzr+ielwBvO72VD
 jKsvLTaEi3ML7RNpGTP2cFJJEcXO63AtIw6mNaIZf/ObnvNn0SZxOMmc6FOTmqDG+AzP
 EIMDclr5h8KfLa4JqD07/Mkjdp1PZY14akRy+6m4lYrwhd9mdNZyh1NMfjszb1xfN8cF gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30x3mbtc5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 11:29:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04CBNvto194793;
        Tue, 12 May 2020 11:29:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30ydsq96cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 11:29:43 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04CBThxT018034;
        Tue, 12 May 2020 11:29:43 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 12 May 2020 04:29:42 -0700
Date:   Tue, 12 May 2020 14:29:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Javier =?iso-8859-1?Q?Gonz=E1lez?= <javier@javigon.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug report] lightnvm: pblk: return NVM_ error on failed
 submission
Message-ID: <20200512112937.GT1992@kadam>
References: <20200511135058.GA216886@mwanda>
 <20200512090318.svnr2iqpyowh62bs@mpHalley.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200512090318.svnr2iqpyowh62bs@mpHalley.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120085
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120085
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 12, 2020 at 11:03:18AM +0200, Javier González wrote:
> On 11.05.2020 16:50, Dan Carpenter wrote:
> > Hello Javier González,
> > 
> > The patch b6730dd4a954: "lightnvm: pblk: return NVM_ error on failed
> > submission" from Jun 1, 2018, leads to the following static checker
> > warning:
> > 
> > 	drivers/lightnvm/pblk-recovery.c:473 pblk_recov_scan_oob()
> > 	warn: 'pblk->inflight_io.counter' not decremented on lines: 426.
> > 
> > drivers/lightnvm/pblk-recovery.c
> >   417
> >   418                  for (j = 0; j < pblk->min_write_pgs; j++, i++)
> >   419                          ppa_list[i] =
> >   420                                  addr_to_gen_ppa(pblk, paddr + j, line->id);
> >   421          }
> >   422
> >   423          ret = pblk_submit_io_sync(pblk, rqd, data);
> >   424          if (ret) {
> >   425                  pblk_err(pblk, "I/O submission failed: %d\n", ret);
> >   426                  return ret;
> > 
> > The pblk_submit_io_sync() increments the pblk->inflight_io counter but
> > doesn't decrement it on all error paths.  It looks like something a
> > little bit subtle is going no but I'm not sure how it works exactly.
> > 
> >   427          }
> >   428
> >   429          atomic_dec(&pblk->inflight_io);
> >                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > 
> >   430
> >   431          /* If a read fails, do a best effort by padding the line and retrying */
> >   432          if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
> >   433                  int pad_distance, ret;
> >   434
> >   435                  if (padded) {
> >   436                          pblk_log_read_err(pblk, rqd);
> >   437                          return -EINTR;
> >   438                  }
> >   439
> > 
> > regards,
> > dan carpenter
> 
> Hi Dan,
> 
> As I recall, we used this counter to see the total I/Os that were
> submitted through pblk and wanted to keep track of how many of them
> completed - so the error path did not decrement as it was I/O that had
> made it to the FTL but had not reached the device.
> 
> I can see how this is confusing, as through time we introduced dedicated
> counters to the failed I/Os and inflight became a counter on I/Os going
> to the device.
> 
> I believe we can fix this by checking the return value on the submit
> functions and decrementing in case of error.
> 
> Do you want me to send a patch or you want to fix it yourself?

Could you send the patch?

regards,
dan carpenter

