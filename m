Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86861C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:08:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA212085A
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 07:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="voopBjA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729727AbfCYHIx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 03:08:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40682 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbfCYHIx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 03:08:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x2P6wxHO075151;
        Mon, 25 Mar 2019 07:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=HWQ5kbHBQxWtPDAQ/NdzhYJ7OTSvXAsnNpX7vP3kHsY=;
 b=voopBjA/lA47y7J0CWliLDIa75VEDhs0tvraqbiUu+NWBYVRC4vUpVSSRlF8nA9MaQY7
 OkxKdSAf88gUvnD7Ov+VpXgzPfo/oMis6OWMvtALlHxXJgH/Mr0yPjpFAqZzAhKFTUVr
 DvpBm8feJKLB5BXvKd3fqlBHu36MBEj6ePDDn63ftmbgVSOcHcYQi70yco4ifxvF6wde
 BFmvwx/NWuhUwShMttZ21892Gf7qi0f3eLXw3xlitofIyeOzwKJ0c6/mZzX6+Ih6HWqE
 kLrHD4FMNZ/lNavG0V8c9At08DX1+tPVL0rXqzgONxYVUG6LF2i21rMOgIBFch1dobaw wg== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2120.oracle.com with ESMTP id 2re6dj27ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:08:16 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id x2P78Ej2022159
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Mar 2019 07:08:14 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x2P78AEh015527;
        Mon, 25 Mar 2019 07:08:10 GMT
Received: from [10.182.69.106] (/10.182.69.106)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 Mar 2019 00:08:10 -0700
Subject: Re: [PATCH V2 2/8] blk-mq: use static_rqs instead of rqs to iterate
 tags
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, jsmart2021@gmail.com,
        sagi@grimberg.me, josef@toxicpanda.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        keith.busch@intel.com, hare@suse.de, jthumshirn@suse.de,
        hch@lst.de, bvanassche@acm.org
References: <1553492318-1810-1-git-send-email-jianchao.w.wang@oracle.com>
 <1553492318-1810-3-git-send-email-jianchao.w.wang@oracle.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <58796005-2f96-ad5c-fa21-b3a0071deb06@oracle.com>
Date:   Mon, 25 Mar 2019 15:12:18 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1553492318-1810-3-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9205 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=905 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1903250053
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jianchao,

On 3/25/19 1:38 PM, Jianchao Wang wrote:
> tags->rqs[] will not been cleaned when free driver tag to avoid
> an extra store on a shared area in the per io path. But there
> is a window between get driver tag and write tags->rqs[], so we
> may see stale rq in tags->rqs[] which may have been freed, as
> following case,
> blk_mq_get_request         blk_mq_queue_tag_busy_iter
>   -> blk_mq_get_tag

Sorry I forgot to mention below when I was studying the v1 patchset.

If there is further review iteration, I would suggest clarify here that
blk_mq_get_tag() would set the bit in sbitmap (e.g., via __sbitmap_get_word())
that bt_for_each() would iterate. Otherwise, please ignore my message.

E.g.,

blk_mq_get_request
  -> blk_mq_get_tag
      -> taint sbitmap tag bit
         without setting tags->rqs[tag]

                                          -> bt_for_each
                                              -> iterate all dirty bit...

This would be much more friendly for people not working on block layer and when
they are looking for the potential fix for a bug by simply searching over the
commit messages. People not working on this would be able to quickly understand
there is a window between setting bit and setting data.


>                              -> bt_for_each
>                                -> bt_iter
>                                  -> rq = taags->rqs[]

%s/taags/tags/g

>                                  -> rq->q
>   -> blk_mq_rq_ctx_init
>     -> data->hctx->tags->rqs[rq->tag] = rq;
> 

Thank you very much!

Dongli Zhang
