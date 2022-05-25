Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10218C433F5
	for <linux-block@archiver.kernel.org>; Wed, 25 May 2022 08:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiEYIcR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 May 2022 04:32:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233543AbiEYIcP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 May 2022 04:32:15 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758251026
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 01:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653467531; x=1685003531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qw6jbP3OUMfdTIpTFPu6JgcWcEnoCdQxVB/Kp7Z7stk=;
  b=eWfnOXj/f9iYCH4j/6ESofmUJepVHPVrXLR9BWXAHe5g83N9ASmjAIVK
   CCdAgCTwSxbLzXoOjAYYtByCCzQhmpNrsyqsvm6A3YyE5T0vL7BwMy1CG
   Q95KfVlcSpycCZMDXmNEIvuljEX2R8KALTNQC8cJM6nKd0oGLCqOtukMZ
   loHEzh5E1moT+mPx/vhqSkyewOGrzP3qkzv/ARaPfnUNL4LS4d10VUBxO
   ebDHx18+f4W7xLldugMdT9RRh3AWfn7Q5ZJo/HYEiwwc7w2KUF1A8IA+Z
   HdHe6qISHtZ/RYPppdNVk21hejPALqQmIpH05m/M3AUJakmgWMzgs78kk
   w==;
X-IronPort-AV: E=Sophos;i="5.91,250,1647273600"; 
   d="scan'208";a="206247121"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 25 May 2022 16:32:07 +0800
IronPort-SDR: kUKi3C7vFJPADTYeDauztnFT+6go+LIc0RsaIoMHkuUqDO8kd2nRhx4Xr+vkJ3VNsahdmVAcfR
 L6iIWcTnpWQUP8EwFEiML0A+0mZ1qb4iqy1T3yzHFjShlRBFBiDGpOEgkj3t93vnq/7QIGX/OW
 F9l25XN5WBQY0YJQQ5w1btR0s1cQIF0B/D5hLj9T8j152G00HgIM0UqFhgkoqvC004H4vktxLF
 1t9myGmvY1CLDPVzLSaCHtB+93O9frc7w99TxNzURfZcbhmgcGq8RrbOshEzJ9LCJWs5tFghDv
 QLfIBx10wyFCD70Qtz/d4qo2
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 00:56:04 -0700
IronPort-SDR: IAPWJeZ69oNEGVIPocNx2zhKe3aZcwnH8T0tsd2Wm9w8z5aPrzmkPWEuDSdhIGPXRA9ShQtZ1q
 veFOcb+KO2fOZYl8KWM/ZRcsDOeqqkKFvZZNXtA2K7SPLKhM0k7DdFNkiFXYAOvknx/9hUKmCf
 cYLrn/OyZbX3r98UuOkpuRnm7mUeJRRCMtfa892cE/zW0tUaCkUPI6Tb9W4LYgeo5Qgzwl0NWZ
 vjUQ3LyfQAuAmv6W+E4gcRQbL+GKNDQBS2qM34lY3SGrjrvkrYYvHYjnltryjCIUgM5ga2M+t+
 Ync=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 May 2022 01:32:08 -0700
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4L7PSS1CDnz1Rvlx
        for <linux-block@vger.kernel.org>; Wed, 25 May 2022 01:32:08 -0700 (PDT)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:content-type
        :in-reply-to:organization:from:references:to:content-language
        :subject:user-agent:mime-version:date:message-id; s=dkim; t=
        1653467527; x=1656059528; bh=qw6jbP3OUMfdTIpTFPu6JgcWcEnoCdQxVB/
        Kp7Z7stk=; b=qanQrtuJ+bc1RTB9IC7sFrYfFvFv2wLg4Kc1DsFK91onCLb4dJS
        MydtjotfEYmGHuSYO0mjiOPwmzT6QX1v0tVNJNvKwn2IeMHJiJkY9IowxjHd95mR
        rwTTKxofg4kzBMaCy3SSqLJ7ocLaaYuhA2z+YHphTzaG78KxA2J8PRzPnG10a1MC
        dN3z80yHlrYNvcUqnuH2daEDRoXeplktZNhdg8emNTWK0sR1uS48HTVjlmWBHkTO
        B/p/1yA9Fx0P7dFmrIeqyk5jSWrSImcvrPVSQumt7iZmNSeWTm9EAineVKHCSKbd
        j+26qlmSLR+X8pEAV1AkzgpiHOB3r8LUYhw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id o161W9UbwVLK for <linux-block@vger.kernel.org>;
        Wed, 25 May 2022 01:32:07 -0700 (PDT)
Received: from [10.225.163.54] (unknown [10.225.163.54])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4L7PSR0T89z1Rvlc;
        Wed, 25 May 2022 01:32:06 -0700 (PDT)
Message-ID: <987d343f-d634-030b-a3be-9cdd8a2904a2@opensource.wdc.com>
Date:   Wed, 25 May 2022 17:32:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH blktests] CONTIRIBUTING, README: transfer maintainer role
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>
References: <20220525020424.14131-1-shinichiro.kawasaki@wdc.com>
From:   Damien Le Moal <damien.lemoal@opensource.wdc.com>
Organization: Western Digital Research
In-Reply-To: <20220525020424.14131-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/25/22 11:04, Shin'ichiro Kawasaki wrote:
> To offload blktests maintenance overhead from Omar, I volunteer to take
> the blktests maintainer role. Replace Omar's name and e-mail address in
> CONTRIBUTING.md with mine. Also note his original authorship in
> README.md.
> 
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Reviewed-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>

> ---
>  CONTRIBUTING.md | 4 ++--
>  README.md       | 3 ++-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
> index 9bda2c4..fd232b7 100644
> --- a/CONTRIBUTING.md
> +++ b/CONTRIBUTING.md
> @@ -2,8 +2,8 @@
>  
>  You can contribute to blktests by opening a pull request to the [blktests
>  GitHub repository](https://github.com/osandov/blktests) or by sending patches
> -to the <linux-block@vger.kernel.org> mailing list and Omar Sandoval
> -<osandov@fb.com>. If sending patches, please generate the patch with `git
> +to the <linux-block@vger.kernel.org> mailing list and Shin'ichiro Kawasaki
> +<shinichiro.kawasaki@wdc.com>. If sending patches, please generate the patch with `git
>  format-patch --subject-prefix="PATCH blktests"`. Consider configuring git to do
>  this for you with `git config --local format.subjectPrefix "PATCH blktests"`.
>  
> diff --git a/README.md b/README.md
> index fcf07ff..4a1d73f 100644
> --- a/README.md
> +++ b/README.md
> @@ -4,7 +4,8 @@
>  
>  blktests is a test framework for the Linux kernel block layer and storage
>  stack. It is inspired by the [xfstests](https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/)
> -filesystem testing framework.
> +filesystem testing framework. It was originally written by Omar Sandoval
> +<osandov@fb.com> and [announced in 2017](https://lore.kernel.org/linux-block/20170512184905.GA15267@vader.DHCP.thefacebook.com/).
>  
>  ## Getting Started
>  


-- 
Damien Le Moal
Western Digital Research
