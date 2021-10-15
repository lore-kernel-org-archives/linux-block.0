Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3858EC433F5
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 03:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C14861090
	for <linux-block@archiver.kernel.org>; Fri, 15 Oct 2021 03:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbhJODcK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 23:32:10 -0400
Received: from mail-pl1-f179.google.com ([209.85.214.179]:42749 "EHLO
        mail-pl1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234199AbhJODcJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 23:32:09 -0400
Received: by mail-pl1-f179.google.com with SMTP id l6so5531694plh.9
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 20:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G1w3ixw12JuIrfIbQi/fT6FSjA8YpsVGWoe+ihky/+I=;
        b=QTzxbIgdbyiYKdoMEl5A2X3efD7by31TH6PkAiNjKF52QhdkmGzPH50THRlM+kv8G/
         MCtZAHn+aMzgUiwllocdYxhYTLWJv1vNAV9U+TtK9TmhsbJFzBjJWCNcvevJGQghZJiG
         Etz5Ar12YtgLVWMuRdAIjzfksKo1sGRpUCrG918FzUSwZRL4ZMRvEcWkkUoenX4uJVrb
         3jLx1sTGzXjggltOLrnd+tLWXGlXkQJ3qj7/g+HFzI+9+Agehh5HbzYxsvLK6Po3PQXN
         DbcTaG6jPoOT26vGj4O+LHErFP4Z4RITkl3ioMqtcStO5EjGscKoPGNTNNLOMnA5TFmk
         hBhw==
X-Gm-Message-State: AOAM531WZI4UZDresU9boKsaf+SzIJXFaC68mT/1jhHLAWhjvniIZXkw
        1Ht6Vnpw/CGZmu//GXbksqU0ioiv9jk=
X-Google-Smtp-Source: ABdhPJwn74LuBMKR8JdXabyVsTFHaZ/R8ARdXp/X3uyaKVybVcvuiUhEHjL9cCMX+rSYv2eIww4syg==
X-Received: by 2002:a17:902:c102:b0:13f:5507:bdc9 with SMTP id 2-20020a170902c10200b0013f5507bdc9mr8728359pli.8.1634268603729;
        Thu, 14 Oct 2021 20:30:03 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:9273:1fed:51da:1c1b? ([2601:647:4000:d7:9273:1fed:51da:1c1b])
        by smtp.gmail.com with ESMTPSA id q73sm3955287pfc.179.2021.10.14.20.30.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 20:30:02 -0700 (PDT)
Message-ID: <a24c9629-be0b-145e-414f-327ad35270e9@acm.org>
Date:   Thu, 14 Oct 2021 20:30:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH blktests] tests/srp: fix module loading issue during srp
 tests
Content-Language: en-US
To:     Yi Zhang <yi.zhang@redhat.com>, osandov@osandov.com
Cc:     linux-block@vger.kernel.org
References: <20211014090455.7949-1-yi.zhang@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20211014090455.7949-1-yi.zhang@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 02:04, Yi Zhang wrote:
> diff --git a/tests/srp/rc b/tests/srp/rc
> index 586f007..f89948b 100755
> --- a/tests/srp/rc
> +++ b/tests/srp/rc
> @@ -494,6 +494,7 @@ start_lio_srpt() {
>   	if modinfo ib_srpt | grep -q '^parm:[[:blank:]]*rdma_cm_port:'; then
>   		opts+=("rdma_cm_port=${srp_rdma_cm_port}")
>   	fi
> +	unload_module ib_srpt && \
>   	insmod "/lib/modules/$(uname -r)/kernel/drivers/infiniband/ulp/srpt/ib_srpt."* "${opts[@]}" || return $?

A nit: the backslash after && can be removed.

Otherwise this patch looks fine to me.

Thanks,

Bart.
