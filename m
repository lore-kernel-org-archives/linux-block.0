Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF206C43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 19:10:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E04C20663
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 19:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="psRNvTar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfCDTKN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 14:10:13 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42566 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbfCDTKM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 14:10:12 -0500
Received: by mail-pg1-f194.google.com with SMTP id b2so3729434pgl.9
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 11:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+qdm+1sCUT8GiXI3wqb2p09U22id6aJTnCpqrYAs/HE=;
        b=psRNvTarQ9Z9mO2XHVKNAyKfHiu8N194D32GfrRHwielgCT5FdaBnQals3by2q3LCd
         bS/R9ThuiRPmOim3zz7pq2uum3n9pCzbn6oxFNvyWa6YV0Hiv/Dc4ylTNDlM2MHFHnnr
         SYPkNE5I4zmnd/Gns53kU6TktpfStO/9Aag7oGJ/HGQnOUixdGPagj7nsPCMyxLF5L4i
         yGJzD+Slo85AwSXeFxdNAa1c+7HMdei2KukvZuxwNrfzmGSnHaTNxjt8sGp/wnCXsAf/
         YM+yB3nZbSYO0LKkuYcPHn3zAl3ySVis8nVZ46sw+NlZ4YaQ107qGhhYJ5OmCktwzz/+
         v2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+qdm+1sCUT8GiXI3wqb2p09U22id6aJTnCpqrYAs/HE=;
        b=WKQPq+iTUWFzy7sxLDfDLbfMhMwIF8c3rdjZcHBwM28Rmr0lSSTVArC14URQFcR29y
         ZO5+dMCJZuVU23rOX8DEQSoe/h5lLMgdhieJDI06csGXQlI5zUZhHm4gHx20XubYRpoJ
         82jNgYJZm6PdB0taGdJN62R7oyxKbkcTf4U96FE5rYWvzaie/EW0DL1/k7RAwFV8I7iS
         KeACf01x9al1VdeQNNBUUHZhbS5Jm0S0S9dTCmHG8z5LJK9hHls/wytRy6YtrItUxrSE
         Nr4IXbxCAFfMfAbBRglD/mWSdWKFQB5il49JMpObZtaHCKFutAaariZESg/UfFwLIyx4
         0DrQ==
X-Gm-Message-State: APjAAAVOQoi+ZVpqHp+83j7h1AtVWns+mf4HEG8Et4K440wjM838xRJv
        wyzUhM141s2ncybvgL/1QbAsMQuOWIg=
X-Google-Smtp-Source: APXvYqx8SqMdR1Y3sszMbJRcR6sObyP5SoKbf1xet7bRPRt9ubt69KGFn6OwYQy2+igZcDKk7tXKjA==
X-Received: by 2002:a17:902:b101:: with SMTP id q1mr22180526plr.296.1551726611046;
        Mon, 04 Mar 2019 11:10:11 -0800 (PST)
Received: from vader ([2620:10d:c090:200::3:9d2c])
        by smtp.gmail.com with ESMTPSA id d129sm9097016pgc.59.2019.03.04.11.10.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 11:10:10 -0800 (PST)
Date:   Mon, 4 Mar 2019 11:10:09 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 0/8] nvme: misc cleanups
Message-ID: <20190304191009.GA5450@vader>
References: <20190221044248.11096-1-chaitanya.kulkarni@wdc.com>
 <20190227185013.GA11806@vader>
 <80D74B0F-BB8E-4E83-ACE2-990E3B9389A8@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <80D74B0F-BB8E-4E83-ACE2-990E3B9389A8@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 01, 2019 at 03:59:53PM +0000, Chaitanya Kulkarni wrote:
> Hi Omar,
> 
> Everything looks good. 
> 
> ﻿On 2/27/19, 1:50 PM, "Omar Sandoval" <osandov@osandov.com> wrote:
> 
>     On Wed, Feb 20, 2019 at 08:42:40PM -0800, Chaitanya Kulkarni wrote:
>     > Hi Omar,
>     > This is a small patch series which follows the blktests coding
>     > style format as pointed out by Bart. Also minimizes the overall
>     > code for the review.
>     > 
>     > -Regards,
>     > Chaitanya
>     > 
>     > Changes since V1:-
>     > 1. Add testcase specific error message on failure.
>     
>     I also made these redirect to $FULL instead of /dev/null. The result is
>     pushed to https://github.com/osandov/blktests/commits/nvme-cleanups,
>     could you take a quick look?
>     
>     Also, I assume I can add your signed-off-by to all of these commits?
> Yes, feel free to add that.

Thanks, merged.
