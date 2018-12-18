Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C170C43612
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1F982133F
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 18:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UzePx8ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbeLRSIw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Dec 2018 13:08:52 -0500
Received: from mail-it1-f178.google.com ([209.85.166.178]:36409 "EHLO
        mail-it1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeLRSIv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Dec 2018 13:08:51 -0500
Received: by mail-it1-f178.google.com with SMTP id c9so5557367itj.1
        for <linux-block@vger.kernel.org>; Tue, 18 Dec 2018 10:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/7+ex9UnH8g38r+W+f+wmgDhY9oGKUrfGL2MviidDhs=;
        b=UzePx8nss5ZWLzZx2s6kh7Hro/sZFpgGVtkTUYzMXamh3qvKUqjikZLyFtt/UETzeq
         sac41S0eHSO2r7JiQxYJG9ly4IzpHK4HjraRtWZ4UAEDGWGoVrbMtL3fXsLTBpnmYuQp
         Zaa32tdL29Rmec510hJodAg6d9tru+4ydQYfhQSbnF/sS1NduZMI7cuS0WLD2Xq5veBx
         1q/aTyzYsgVmRwcqXZ8ib5gvw5ZwaSP6qEsTyr15LzZGrhJQWNEbiNF7tpFKbJzZlg6k
         R+lJXc0JQ0HYo9py2SMq9K4PjezVv8QfqKDH5OCkwNzxVWIJO2GJykIHGsASVw2ZAH8E
         UD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/7+ex9UnH8g38r+W+f+wmgDhY9oGKUrfGL2MviidDhs=;
        b=GrM3+iRBjMo+U9ShP6hsxeAM8gbzyIvAz9TISozf8RtvrKHwqD+NthN2GpC2mrcBot
         DndeFxqdS5mVWlbvRTB6CxG2nwkQ9xLYo5MZmkHfNtSfGx7XodQTDNMC6ZAq6zgMuD0c
         hCpw2ONKuzADxXir/tdBjJFirWaUyuU1PxnEHlpPlKMgQpecnup67vNQ7KuajBWjBJgu
         9ZTlGfvxyDASHqLe3QDYD8aK8LmQ+pyR1IQ2X4wVdqWNVqjJ+vgLfmX7SmGhxvgfQDWp
         ZJJLwd3yFco3na5BM+IWAx7rl1oQm8B8EbqbQtdPOnDKrj4b6oO6nWmjaDlM7hg/JSwH
         YkZA==
X-Gm-Message-State: AA+aEWaAceRwACpJcYHKsTTCEyhUxGweCf+2+Aetqtx0nINLiZVt5wHC
        iPxk6/m7L1XKWcSOTqDI4MmcYw==
X-Google-Smtp-Source: AFSGD/XXJX40jvTLdFF2rGQGeXdskEqwS2ra0wzwAwr4J+zFyH4wehIT9Q2ocBgBzTQAab6VxZRQew==
X-Received: by 2002:a02:3da:: with SMTP id e87mr15497580jae.78.1545156530631;
        Tue, 18 Dec 2018 10:08:50 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id s18sm5204391ioj.67.2018.12.18.10.08.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 10:08:49 -0800 (PST)
Subject: Re: Unintuitive scheduling results using BFQ
To:     Paolo Valente <paolo.valente@linaro.org>,
        Madhav Ancha <mancha@tower-research.com>
Cc:     linux-block <linux-block@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <CA+XCsb-0M8PXB30zd22c_nmww5OvMs4mKEcsFahMR7jV+9+01g@mail.gmail.com>
 <8FCED0AE-6BE7-42EE-92ED-58E2B622A165@linaro.org>
 <CA+XCsb-0vY+x1+jSSRYcLdYz+U_T77QefQVWEoikSS5bfevjpg@mail.gmail.com>
 <C8B5F877-6F4B-46AD-9AC9-BAE91C754A5F@linaro.org>
 <CA+XCsb8eiq7w-W5ecPNdnqvrv1dU4Vkq=HfKCG=MoQi_CekPBg@mail.gmail.com>
 <255AD47C-65DD-4F22-9E64-8DF9DD81B83B@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <eb245572-a504-37d6-dd15-d1b502816940@kernel.dk>
Date:   Tue, 18 Dec 2018 11:08:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <255AD47C-65DD-4F22-9E64-8DF9DD81B83B@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/18/18 11:04 AM, Paolo Valente wrote:
>  static bool bfq_symmetric_scenario(struct bfq_data *bfqd)
>  {
> -	return !bfq_varied_queue_weights_or_active_groups(bfqd);
> +	/*
> +	 * For queue weights to differ, queue_weights_tree must contain
> +	 * at least two nodes.
> +	 */
> +	bool varied_queue_weights = !RB_EMPTY_ROOT(&bfqd->queue_weights_tree) &&
> +		(bfqd->queue_weights_tree.rb_node->rb_left ||
> +		 bfqd->queue_weights_tree.rb_node->rb_right);
> +
> +	bool multiple_classes_busy =
> +		(bfqd->busy_queues[0] & bfqd->busy_queues[1]) |
> +		(bfqd->busy_queues[0] & bfqd->busy_queues[2]) |
> +		(bfqd->busy_queues[1] & bfqd->busy_queues[2]);

I don't think this does what you want it to, looks like these should be
logical AND and OR.

-- 
Jens Axboe

