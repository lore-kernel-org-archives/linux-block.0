Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3101AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 24 Jun 2022 09:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiFXJ7x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Jun 2022 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiFXJ7w (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Jun 2022 05:59:52 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 14DCA69FA2
        for <linux-block@vger.kernel.org>; Fri, 24 Jun 2022 02:59:50 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AQBGf5aLzI11Q5493FE+R7JclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDr0msl1jRVnTYfCDyAOq6MZDSnfNxzbIW08xgHvsfUnINqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+MzvuRGuK59yMkj/nRHuOU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatTozGIjdBwytREs7S+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZ/AZouCdcCnXXcu7iheun2HX6/FvClwmeIcc/e10KX9?=
 =?us-ascii?q?B+OZeKz0XaB2HweWsz9qTUeltgMUoLMjxO8Ucs25p1jjaDN45TZuFSKLPjeK0d?=
 =?us-ascii?q?h9YattmRK6YPpRGL2E0KkmoXvGGAX9PYLpWoQtirieXn+VklW+o?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AaLnWg6GDDdaKkPLqpLqEcseALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc3Nom7+j5riTdZMgpGbJYVcqKRcdcL+7Scu9qB/nlaKdpLNhWotKPzOW3F?=
 =?us-ascii?q?dATrsSjrcKqgeIc0aVm9K1l50PT0EUMrzN5DZB4foSrDPIdurI3uP3jJyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOAEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmMawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTZj82G?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="125727299"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 24 Jun 2022 17:59:50 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id F0D824D68A3E;
        Fri, 24 Jun 2022 17:59:46 +0800 (CST)
Received: from G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 24 Jun 2022 17:59:47 +0800
Received: from [192.168.122.212] (10.167.226.45) by
 G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 24 Jun 2022 17:59:46 +0800
To:     <shinichiro.kawasaki@wdc.com>
CC:     <linux-block@vger.kernel.org>, <yangx.jy@fujitsu.com>
References: <20220624082039.5x2cl26q7v6rnm5n@shindev>
Subject: Re: [PATCH blktests] nvmeof-mp/rc: Avoid skipping tests due to the
 expected SKIP_REASON
From:   "Li, Zhijian" <lizhijian@fujitsu.com>
Message-ID: <3e731962-6bf1-e45d-0b57-04a41c96dd96@fujitsu.com>
Date:   Fri, 24 Jun 2022 17:59:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20220624082039.5x2cl26q7v6rnm5n@shindev>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-yoursite-MailScanner-ID: F0D824D68A3E.AE361
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: lizhijian@fujitsu.com
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On Jun 24, 2022 / 15:50, Xiao Yang wrote:
> > In _have_kernel_option(), SKIP_REASON = "kernel option NVME_MULTIPATH > has not been enabled" is expected but all nvmeof-mp tests are 
> skipped > due to the SKIP_REASON. For example: > 
> ----------------------------------------------------- > ./check 
> nvmeof-mp/001 > nvmeof-mp/*** [not run] > kernel option NVME_MULTIPATH 
> has not been enabled > 
> ----------------------------------------------------- > > Avoid the 
> issue by unsetting the SKIP_REASON. > > Signed-off-by: Xiao Yang 
> <yangx.jy@fujitsu.com>
> Good catch. Thanks!
>
> This issue was triggered by the commit 7ae143852f6c ("common/rc: don't unset
> previous SKIP_REASON in _have_kernel_option()"). So let's add a "Fixes" tag to
> note it.
>
> > --- > tests/nvmeof-mp/rc | 5 +++++ > 1 file changed, 5 insertions(+) > > 
> diff --git a/tests/nvmeof-mp/rc b/tests/nvmeof-mp/rc > index 
> dcb2e3c..9c91f8c 100755 > --- a/tests/nvmeof-mp/rc > +++ 
> b/tests/nvmeof-mp/rc > @@ -24,6 +24,11 @@ and multipathing has been 
> enabled in the nvme_core kernel module" > return > fi > > + # In 
> _have_kernel_option(), SKIP_REASON = "kernel option > + # 
> NVME_MULTIPATH has not been enabled" is expected so > + # avoid 
> skipping tests by unsetting the SKIP_REASON
> Can we have shorter comment? Like:
>
>          # Avoid test skip due to SKIP_REASON set by _have_kernel_option().
>
> > +	unset SKIP_REASON

Well, IMO it's not always correct to unsetSKIP_REASON, for example, if 
the OS didn't have kernel config file, we should report the test as 'not 
run'

Thanks

Zhijian


> > +
> The change above looks good to me, and I confirmed it fixies the issue.
>
> -- 
> Shin'ichiro Kawasaki



