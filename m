Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C03AC433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Feb 2022 23:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbiBUXQv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Feb 2022 18:16:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230271AbiBUXQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Feb 2022 18:16:50 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB9B6566
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 15:16:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1645485384; x=1677021384;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PGqqQFL1b02Ybwd76UaWtneSNZC/VMfI4T9d50KFpt4=;
  b=fS/1Pc3G5LTzPc45c3/cMfb7LeuqmRpXllOV2FvFaGsYaBf02jj77i1s
   2icgk4b6Knn8AyNLRR3f7jgBLLB/Xn6A+YekEHlVKow4u6pHisiwk71KN
   Uxv9ZtzgQarq7cDgDRB+JNicvfta4YnsbndEXt6GmWzqhH6cR0Nvg9vji
   o+OcM919L7fd/H+iitCxQ0WLE2fBXCG5CfnNMJVPJfJh+MOzvwbV+6RnP
   c50uek/ddK46pu8+ycvPTQ6HSiCSZbhZ2ph7kcqwOM3zpQyugolnlDNJP
   gLC567QXsgW8Xt9D6E+XwCGKz6WigTg4vtvqneAUBOaZB1XonvtyHR1YO
   A==;
X-IronPort-AV: E=Sophos;i="5.88,386,1635177600"; 
   d="scan'208";a="305486196"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Feb 2022 07:16:24 +0800
IronPort-SDR: F6k87eF4YtnliPrBzGncT81EIeELomjQc7gu/bCpLlBbraUM3OHg38fxyZfyi2a86wVrknaf/f
 BDKcjYK8R/wuR+3wIY+T0u3BIh/V3lTJ7JT3pB8tVcarc+55M94BzU+RTLp3XboeoruXWBXKb0
 2Z3xwdKUl/KEEUVWgs8vFZa6W3xdxQZULbe6+12eA7qMJ4bPgsIQk3XJzX5BjLdwbqvn+Ce7kU
 eEgDdCQLSMqchEyRE0ln95YGCanCXCHj7R989neI5d9P8rQOTVjr6+SEkyRmekoKfsKdI89EzF
 1KZuL1ZC4EFTAIWZEciBPTxQ
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 14:49:04 -0800
IronPort-SDR: x1F9SmesxybKN8+tMunP0Ivc66IIaavTXMpQEiz72KCYgxcYHNYldHnopNoJjd0a1vMdirFD3E
 5rcjfb8BEglCopYAaI3xmhCb5lRWV2mVNm8FAabg1WrivSajnSbdoqXT7TemCrH4owEO9SWllS
 9vUD+fAVTX/IHtDxaKkA1iA3RacjwcSu3b4fGIg8MNjvCXJpH+5QOK9B+b7dQ3tIGlXUiBpYs9
 BXfEvIusaTAgdUuP1rXKQBYtusblzNHCXF2jtvXGaN9bnDqNj2t6exhI8idXdtSu5BEbZQvQSu
 lVo=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 15:16:24 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4K2dTh38Hgz1SHwl
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 15:16:24 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1645485383; x=1648077384; bh=PGqqQFL1b02Ybwd76UaWtneSNZC/VMfI4T9
        d50KFpt4=; b=lelQ0lJPvh1u3EVw70tvw4RpHHV3PA3rt496Sw5DMridB5poVPv
        WEGqr6r9Ueq7WfuZRos+bIyO6S1iNr9rHTXFSB8auMp+yVQOzDE30o/RRG8VH5s2
        39EveZF6IseAdYNn44aEjTXdEvfCEpr4YhfJbOjesBOuvI5frLSJrZ5q9TBDDgp8
        9Ne1y6V4fjv1qAMqeNcvzCL4iFTGZtcXTUaG4JQZppuKZCyNxr6ZXlb72dNA7K7k
        yxa9e6uUMnDFx1CXoE7wGJWTPquV5dzHd/bsXN4h2XRfEuGgpYNKNYaR8enOK7sI
        BlAnwksud7OSPtScWmV+U9Ee00Oaglu9Gcw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LHdi07DJtF3n for <linux-block@vger.kernel.org>;
        Mon, 21 Feb 2022 15:16:23 -0800 (PST)
Received: from [10.225.163.81] (unknown [10.225.163.81])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4K2dTg1GL5z1Rvlx;
        Mon, 21 Feb 2022 15:16:22 -0800 (PST)
Message-ID: <18da367b-bbe1-c591-358e-6f8111a90eaf@opensource.wdc.com>
Date:   Tue, 22 Feb 2022 08:16:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Content-Language: en-US
To:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
References: <87tucsf0sr.fsf@collabora.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <87tucsf0sr.fsf@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/22/22 04:59, Gabriel Krisman Bertazi wrote:
> I'd like to discuss an interface to implement user space block devices,
> while avoiding local network NBD solutions.  There has been reiterated
> interest in the topic, both from researchers [1] and from the community,
> including a proposed session in LSFMM2018 [2] (though I don't think it
> happened).
> 
> I've been working on top of the Google iblock implementation to find
> something upstreamable and would like to present my design and gather
> feedback on some points, in particular zero-copy and overall user space
> interface.
> 
> The design I'm pending towards uses special fds opened by the driver to
> transfer data to/from the block driver, preferably through direct
> splicing as much as possible, to keep data only in kernel space.  This
> is because, in my use case, the driver usually only manipulates
> metadata, while data is forwarded directly through the network, or
> similar. It would be neat if we can leverage the existing
> splice/copy_file_range syscalls such that we don't ever need to bring
> disk data to user space, if we can avoid it.  I've also experimented
> with regular pipes, But I found no way around keeping a lot of pipes
> opened, one for each possible command 'slot'.
> 
> [1] https://dl.acm.org/doi/10.1145/3456727.3463768

This is $15 for non ACM members... Any public download available ?

> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
> 


-- 
Damien Le Moal
Western Digital Research
