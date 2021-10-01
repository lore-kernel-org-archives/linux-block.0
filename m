Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1999EC433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 19:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9CD061AEB
	for <linux-block@archiver.kernel.org>; Fri,  1 Oct 2021 19:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355381AbhJATgS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Oct 2021 15:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355378AbhJATgS (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Oct 2021 15:36:18 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B982C06177E
        for <linux-block@vger.kernel.org>; Fri,  1 Oct 2021 12:34:32 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 145so8824473pfz.11
        for <linux-block@vger.kernel.org>; Fri, 01 Oct 2021 12:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pC2h0lvxVc5KKbfREaINSac8mB+N4kKtlvuyg5h36LM=;
        b=gaz6fykW+fGnn4VCynEBOrUpzKeZ76AGT+VgU6sytw7i+wiZzMyCdiiBnH3jnCbOae
         HPyhldhxOrcMbbXsvP9qAP4H9SRrJHK3Xl2N+XfKJ4dg2aPqFG84OFqSWpEg6qJ253ZD
         9mCjkD2Ymz6cAQQhFFDQKAcpubqGJDjb9Z8WQ52HUXJvDW/tSZSf/9b7lQsmm1ahPJuT
         RdJuBOSMI4ipy5NRZFko2USS/Muiyx7dPu9eLnucJUB5ZfhH5LIAfu7mKM7975UVsthA
         VelzQHOMSEunp9akUui2aVUrSiSQinvuKFXk9PAyVX+m35NqLY+AUSjCRfLKxmV31CBP
         Iy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pC2h0lvxVc5KKbfREaINSac8mB+N4kKtlvuyg5h36LM=;
        b=JCuH0sgYb0AWGiRAnm4VFXIYBoK4UHkNIDk+/shfiWZX2xjZsfCOGB3KVW7mvHuHW5
         e8lZ7nZbkTuSjAq9o1G7zkX+A7w51ZvI0eXphIX4vZ0Hu95L/cPQaxr4nbwLTINoTXmO
         j6QGks/7RpgeNhMyCKoPY691vHygwuX0jQ89TUHeRdyBNY4A2JeW9p3rZdmHE+cC6xD+
         q8qvnV2sh4asxMl6jENcnX8JAM9OSKER2cVWwD6wRb4/T+s1oM62EHZbP+EaAnMMp/IT
         AA9KYc16eaT4YcjZNAT9f560VxNxq8cIaj8fTByliVAFe49Gx2UlAEu1FlYIKshm3QpU
         sYCA==
X-Gm-Message-State: AOAM533a4/D9bhzaFy9ZozPTNTn1SW9k5zinhXqlzJp7zOUCydzrTpoO
        4jEZncPKFnFmqGTPy+x0bPtyEQ==
X-Google-Smtp-Source: ABdhPJz8Y6Est+kcYAdUgYNMXKg2inqkeqt0BuMfy617uJfYtPLY+lFyOXV27MxLDNz+1RjD9rXGtA==
X-Received: by 2002:a63:67c3:: with SMTP id b186mr10968030pgc.229.1633116871656;
        Fri, 01 Oct 2021 12:34:31 -0700 (PDT)
Received: from ?IPv6:2600:380:4a74:fb92:622f:875a:688c:3102? ([2600:380:4a74:fb92:622f:875a:688c:3102])
        by smtp.gmail.com with ESMTPSA id h6sm8785321pji.6.2021.10.01.12.34.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Oct 2021 12:34:31 -0700 (PDT)
Subject: Re: [PATCH] sx8: fix an error code in carm_init_one()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-block@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20211001122722.GC2283@kili>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <a400edbf-da11-e8b1-8eef-221c6493bae1@kernel.dk>
Date:   Fri, 1 Oct 2021 13:34:28 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20211001122722.GC2283@kili>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/1/21 6:27 AM, Dan Carpenter wrote:
> Return a negative error code here on this error path instead of
> returning success.

Applied, thanks.

-- 
Jens Axboe

