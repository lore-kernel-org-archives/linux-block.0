Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10168C76196
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 18:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbjDKSNl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 14:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjDKSNl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 14:13:41 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A441E4E
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:13:40 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id w11so9335686pjh.5
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 11:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681236819; x=1683828819;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=awmuuqBYj1VqzG0DY9y5+owYgaqKCBaXjRRC6Ry737w=;
        b=DI/8D4M9ZjeUDrzTuZroQEzF3I7zZwzwqbyyUI3r5wtWQZl098F+lKkiAM0iDLaZLw
         cccDiRhIdTDkT6m39pYRNXzmrfjzBvdLVZWdHkNOls/RGMsjN1ZZByQMaUnfxBuqWZIF
         gA8JttmzJjpbqeXJJJu0F4ek0YSmXhx7O5vG2OFqmkSa/bk0rzKi6Iog4lyGpoFsBjZX
         jtPu4Y/7kksk/OKFlJ9yYDB0ARe8SrhABliSLGuAVBmGAGL+6UpWlKVBXadEU0JyC8rz
         YOxLANnl5eoprSUOXTtbuRDRcBG5DilFYT4hzksH2uoyMpcvQ5N+7WhBxCcmfi5//hXd
         /Xvg==
X-Gm-Message-State: AAQBX9fR2MIkRyaumzYGo4+Ag3cOU99YtJNbYQ0m2Jc7OOde0nHAhzxJ
        cJ9CP2Df0ANzIyBNLHyAeAc=
X-Google-Smtp-Source: AKy350ZWqsi2ZKTtaQLVN/EoT9Q4RLcVz07TANE93NSOlFdHyfSFeQx1hEN+eBj/xZdcMKoYHPIUcw==
X-Received: by 2002:a05:6a20:3b07:b0:cc:7967:8a75 with SMTP id c7-20020a056a203b0700b000cc79678a75mr2891909pzh.46.1681236819344;
        Tue, 11 Apr 2023 11:13:39 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:646f:c9f7:828a:8b03? ([2620:15c:211:201:646f:c9f7:828a:8b03])
        by smtp.gmail.com with ESMTPSA id bm1-20020a056a00320100b0062dd993fdfcsm10194939pfb.105.2023.04.11.11.13.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 11:13:38 -0700 (PDT)
Message-ID: <55f97758-138c-4522-0e6d-3930f57a31f6@acm.org>
Date:   Tue, 11 Apr 2023 11:13:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 16/16] blk-mq: pass the flags argument to
 elevator_type->insert_requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
References: <20230411133329.554624-1-hch@lst.de>
 <20230411133329.554624-17-hch@lst.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230411133329.554624-17-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/23 06:33, Christoph Hellwig wrote:
> Instead of passing a bool at_head, pass down the full flags from the
> blk_mq_insert_request interface.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
