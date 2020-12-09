Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0029FC2BB9A
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B158823B98
	for <linux-block@archiver.kernel.org>; Wed,  9 Dec 2020 08:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgLIIEU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Dec 2020 03:04:20 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50194 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728616AbgLIIET (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Dec 2020 03:04:19 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B97xNqi006094;
        Wed, 9 Dec 2020 08:03:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=JgWUramQ4RWjeQKitCLWZEl8JrsgQKifBI74AB7jLB8=;
 b=OhgPKeNvaIjlHpKIt9U4k5bRSNW9yKHo8S257oiYb7C4Bxy+TxVuEDtwFWrqNwr0x2ic
 zKdQhs27UOOpR90+Z5vIbLbERB0k6s0rwN0NKHJng/bEphQmMcIx2mgNRyM9iPOl+tB3
 IlKoQt3do4/rBjuV09IoE5k5CHEi3RZH650JTAH+PM28Zv9/V9L7wsty3tZp4qRrfvUT
 uHfOLiIHWXMNkDAk1xMKmmkRx6b+nmsqmSMBXBBhffzj4tOT42+zV1QzLroS5a/Hery3
 h1B2EOcedlg1T8mF+E6T4v42/CwC7ZD4x4cONhAgkTL1s2xzc8NNVwiYoMrc9tnV8sTV fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 357yqbxu6s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 08:03:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B980osC020588;
        Wed, 9 Dec 2020 08:03:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 358kspqrj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 08:03:32 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0B983Vn3029963;
        Wed, 9 Dec 2020 08:03:31 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 00:03:30 -0800
Date:   Wed, 9 Dec 2020 11:03:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Jinpu Wang <jinpu.wang@cloud.ionos.com>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        Md Haris Iqbal <haris.iqbal@cloud.ionos.com>,
        Jens Axboe <axboe@kernel.dk>,
        Lutz Pogrell <lutz.pogrell@cloud.ionos.com>,
        linux-block <linux-block@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] block/rnbd-clt: Fix error code in
 rnbd_clt_add_dev_symlink()
Message-ID: <20201209080323.GE2767@kadam>
References: <X9B0IyxwbBDq+cSS@mwanda>
 <CAMGffEn6a92UDBgzkR2L6wutNBpxY_xNf3cakvbivkaGRnk_uQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMGffEn6a92UDBgzkR2L6wutNBpxY_xNf3cakvbivkaGRnk_uQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090056
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 bulkscore=0 phishscore=0 adultscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012090056
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Dec 09, 2020 at 08:36:31AM +0100, Jinpu Wang wrote:
> Hi Dan,
> 
> 
> 
> On Wed, Dec 9, 2020 at 7:52 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > The "ret" variable should be set to -ENOMEM but it returns uninitialized
> > stack data.
> >
> > Fixes: 64e8a6ece1a5 ("block/rnbd-clt: Dynamically alloc buffer for pathname & blk_symlink_name")
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> Thanks for the patch. But there is already a fix from Colin merged in
> block tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.11/drivers&id=733c15bd3a944b8eeaacdddf061759b6a83dd3f4
> 
> There is still other problem through with commit 64e8a6ece1a5
> ("block/rnbd-clt: Dynamically alloc buffer for pathname &
> blk_symlink_name")
> 
> I will send the fix today together with other changes.

Ah...  Haha...  Sorry about that.  We already discussed this yesterday.

What happens is that when I write a patch, I normally save it in my
postponed messages until the next day.  But then I decided to not fix it
but instead to just report it.  Unfortunately, I forgot to delete it and
I also forgot about yesterday's discussion because I have the memory of
a gnat.  :P

regards,
dan carpenter

