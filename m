Return-Path: <SRS0=zJbT=SF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 752AAC10F0B
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 01:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 455232146E
	for <linux-block@archiver.kernel.org>; Wed,  3 Apr 2019 01:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfDCBFX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Apr 2019 21:05:23 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33825 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfDCBFX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Apr 2019 21:05:23 -0400
Received: by mail-pg1-f194.google.com with SMTP id v12so7425801pgq.1;
        Tue, 02 Apr 2019 18:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wk1oCgdMEVkKea+GRaLY02XjU5pX8klUWob72/CdDPY=;
        b=Vp8h/0imxvIuzF3sdU50tWIAVF5FunU60XG0lxVe1/dbt3wQbzkhXso3SrZmA42g8W
         nST75B32nIy8QIiHe7r4Y76vGLMPBmmi9+/5/YpRLsLZk8mmydF16bl0BFqOzXNbgVJ3
         EKFEr5d86Ht7pD5E815xr/OGrF7QgjfTzQONYs6T9s0kOKCxK6n8H1k2ucblTCVeb6VX
         JJhP822CP+XHWbkrimQuN9wsvTRaEuGUtq7bGM8pkoo+fH71LLMDspwBVuq+0PU1mERr
         xGqJi/fEe8SlZSp6uGatA9JoMt00MVK48EQlrrlZHXeJPLhuhEv+OK9IcVfb12Js5Eol
         u8Lw==
X-Gm-Message-State: APjAAAVLEklIgrDV98qy6OZBHwRVAjTcl7T5hmTUyZDrXmkNhc9204Yw
        8EGaxHdx5A3rfUzpBRjcgEOiExj+oAI=
X-Google-Smtp-Source: APXvYqwA9CfbwutdFxJuqBgV16JqWToLSBTOLgBnDWtCa9U/uCulStc/OAR4pxnr7ZmuNh1HAwz1Jw==
X-Received: by 2002:a63:1548:: with SMTP id 8mr31256832pgv.277.1554253522462;
        Tue, 02 Apr 2019 18:05:22 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id w2sm20795820pgp.81.2019.04.02.18.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Apr 2019 18:05:21 -0700 (PDT)
Subject: Re: [PATCH] block: Fix a race between tag iteration and hardware
 queue changes
To:     Dongli Zhang <dongli.zhang@oracle.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Keith Busch <keith.busch@intel.com>, stable@vger.kernel.org
References: <20190402223202.30752-1-bvanassche@acm.org>
 <3f83312b-7896-54d9-1a7b-a3abacc04e46@oracle.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <1fa3ad06-0b4c-e1e0-ffc9-2390b84584da@acm.org>
Date:   Tue, 2 Apr 2019 18:05:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <3f83312b-7896-54d9-1a7b-a3abacc04e46@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/2/19 6:02 PM, Dongli Zhang wrote:
> I used to see the removal of above in one of Jianchao's patchset.
> 
> https://lore.kernel.org/patchwork/patch/1051047/

Thanks for the feedback. But it seems like the q->mq_freeze_depth test 
is missing from Jianchao's patch ...

Bart.
