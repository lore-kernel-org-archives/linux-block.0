Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246CAC11F66
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 14:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99D6608FE
	for <linux-block@archiver.kernel.org>; Tue, 13 Jul 2021 13:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbhGMOCs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jul 2021 10:02:48 -0400
Received: from mail-pl1-f172.google.com ([209.85.214.172]:44883 "EHLO
        mail-pl1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236750AbhGMOCs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jul 2021 10:02:48 -0400
Received: by mail-pl1-f172.google.com with SMTP id o8so1728536plg.11
        for <linux-block@vger.kernel.org>; Tue, 13 Jul 2021 06:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=811SFH/xxVOzsPExEnBlyuKpX/zrfI7/n6Kfonn2mcc=;
        b=nhn4oWxpqL8U9eWI+Uk5BW6+hz1LyPrZ/Gpg6UbJZ1DT1KuV/YuhDbOSpEr8qHidjr
         q4rEMXqQLX/yaqm35KH1ttTy2gKPeDXsgMfiPUlhw8fmUPiq8K4F2T0BGSJx47lWfU/6
         TbJMtHlc1vtsw7wgg6kLoolvD/LRljDtvh0O1+DmL8j9Vbt5rV94MzHZfPgJgRpkUVVF
         fntF/KglWkZDPDztLQAsIywF8LtUlCq170HnU7d/x8TtUcsIJ51DYznh8C8yPzqMUhTC
         2iZ9cYM71vVXzd86y6GywUYRwu4MvyJmkF/qrzZTVr9nP1TPxNsMJMBkoZVn5LbGIS3Y
         0YKQ==
X-Gm-Message-State: AOAM532r2/fv98oEjdABVHoEs6YajXJUsGHHtPJB+wgCL9FKRfIWORUH
        ue2ANz8f+f0cOP3kSW5ijDM=
X-Google-Smtp-Source: ABdhPJxqVhmKnFISCKqcEpiRodkxsjwtvFBloTj6w0JwM1MSL84ezpogs7lZ8X3Nyf2k/aAIIXIR9Q==
X-Received: by 2002:a17:903:408c:b029:12a:f74f:4b0 with SMTP id z12-20020a170903408cb029012af74f04b0mr3609809plc.65.1626184797159;
        Tue, 13 Jul 2021 06:59:57 -0700 (PDT)
Received: from ?IPv6:2601:647:4000:d7:38e:7ae8:7e71:3890? ([2601:647:4000:d7:38e:7ae8:7e71:3890])
        by smtp.gmail.com with ESMTPSA id 31sm21692108pgu.17.2021.07.13.06.59.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jul 2021 06:59:56 -0700 (PDT)
Subject: Re: [PATCH blktests 1/2] zbd/rc: Support dm-crypt
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org, Omar Sandoval <osandov@osandov.com>
Cc:     Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
References: <20210713101239.269789-1-shinichiro.kawasaki@wdc.com>
 <20210713101239.269789-2-shinichiro.kawasaki@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <17ed9d08-ecd2-abb6-544e-33bff88b7504@acm.org>
Date:   Tue, 13 Jul 2021 06:59:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210713101239.269789-2-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/13/21 3:12 AM, Shin'ichiro Kawasaki wrote:
> -	# Parse dm table lines for dm-linear or dm-flakey target
> +	if _test_dev_has_dm_map crypt; then
> +		dev_idx=6
> +		off_idx=7
> +	fi
> +
> +	# Parse dm table lines for dm-linear, dm-flakey or dm-crypt target
>  	while read -r -a tbl_line; do
>  		local -i map_start=${tbl_line[0]}
>  		local -i map_end=$((tbl_line[0] + tbl_line[1]))
> @@ -355,10 +362,11 @@ _get_dev_container_and_sector() {
>  			continue
>  		fi
>  
> -		offset=${tbl_line[4]}
> -		if ! cont_dev=$(_get_dev_path_by_id "${tbl_line[3]}"); then
> +		offset=${tbl_line[off_idx]}
> +		if ! cont_dev=$(_get_dev_path_by_id \
> +					"${tbl_line[dev_idx]}"); then
>  			echo -n "Cannot access to container device: "
> -			echo "${tbl_line[3]}"
> +			echo "${tbl_line[dev_idx]}"
>  			return 1
>  		fi

To me the above code looks like code that is hard to maintain. Can the
above parser be replaced by reading /sys/block/*/slaves? An example from
my workstation for dm-crypt:

$ ls /sys/block/dm-0/slaves
nvme0n1p2

Thanks,

Bart.
