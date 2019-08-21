Return-Path: <SRS0=wMiD=WR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A6DC3A59E
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70F1F22CF7
	for <linux-block@archiver.kernel.org>; Wed, 21 Aug 2019 15:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfHUP5j (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Aug 2019 11:57:39 -0400
Received: from mail-pf1-f176.google.com ([209.85.210.176]:45633 "EHLO
        mail-pf1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726828AbfHUP5i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Aug 2019 11:57:38 -0400
Received: by mail-pf1-f176.google.com with SMTP id w26so1685225pfq.12
        for <linux-block@vger.kernel.org>; Wed, 21 Aug 2019 08:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G3jXO4XrOXQgUzu5m07uD2jAZyM7+jubCsDqjvIpibQ=;
        b=SXwbxGu6gpGK1sFdKkrhsCBx3xZrgVzQWJ2Z1NugZpjcf+iEKEdzIQ269+zkH+aPjY
         qSGI22zZpQ+GdqaBcO5yRXxMoMtahw6i5mqfTPqUC5HjRnLcGnznU/r+juVES4pHEvtN
         qU52tDvcaa5+lIv3PJ2/+OQDB1wDX1CVr9WXlX5BlGfe7vvheCOY963IQbJ3qScnrdUH
         ye7ZSz+co30jCMbb3zFQh2yOJXmh/x6hoOHaIub74oQF9duORkOhEMg7bC0AwjOWEsRX
         dNF4J+gKMqqeqEfDNK8HAPbJs/UxKdem1wbyvjtcgVEGdMrx4n9nqyu6xvRDtFVoLMLm
         BTzw==
X-Gm-Message-State: APjAAAWlcFRicI1QvN4LBjKkkYww7hf2kZySRyM9SoYlgQi3fKLCxo3m
        ZDb4mbq7e8nd+Wx6RPMkrq4=
X-Google-Smtp-Source: APXvYqx++yXs71KIQvOrGgHi+Yav/frCxu/p0e1scIXH4jwhNM9+Qu4vJCp0Hi9ux54eu7cTxY4iKQ==
X-Received: by 2002:a17:90a:d593:: with SMTP id v19mr681730pju.1.1566403058092;
        Wed, 21 Aug 2019 08:57:38 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id s72sm31953795pgc.92.2019.08.21.08.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2019 08:57:37 -0700 (PDT)
Subject: Re: [PATCH V2 5/6] block: add helper for checking if queue is
 registered
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Mike Snitzer <snitzer@redhat.com>
References: <20190821091506.21196-1-ming.lei@redhat.com>
 <20190821091506.21196-6-ming.lei@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a7f8b78c-bdc9-f8b8-64bd-f279cc246354@acm.org>
Date:   Wed, 21 Aug 2019 08:57:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190821091506.21196-6-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/21/19 2:15 AM, Ming Lei wrote:
> There are 4 users which check if queue is registered, so add one helper
> to check it.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
