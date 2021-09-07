Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034F3C433EF
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0025610E9
	for <linux-block@archiver.kernel.org>; Tue,  7 Sep 2021 14:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbhIGOl5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Sep 2021 10:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231362AbhIGOl5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Sep 2021 10:41:57 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AEEC061575
        for <linux-block@vger.kernel.org>; Tue,  7 Sep 2021 07:40:50 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a22so5011118iok.12
        for <linux-block@vger.kernel.org>; Tue, 07 Sep 2021 07:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wW7nDkAHdnr9E6lho99qrzF6q0AQdn4I37de/4jvj+Y=;
        b=seup/c4gyZDLP2geh/XwDGrHkqRiCN4KJXSd1jkF3GTeivEEI73a3Th0w8w01t4KWd
         BtAPVPzynhHQgJ2XwJ44L8fueKVFR9LHcjgjN+s/EC8XLbXeDchWYVKZaaYzD42pPsSN
         3YVdcKTdURDNHf39NuCFi8cGeNFTZ5D7KFjj/1g8EabKRmdJHPdStJZUmgrFUAWJnfeO
         j0XGF21K39Gmam1nFpflABDkZxK6zEa5huJ2uJHxdge41Y5/GX0C5+XAdK0Y5IpyxcCU
         DzOK8m9oWOFRnmC9W4bkmgwa3Mvghzyhtio9NeS8AZWPe1toyBoj3ATFcVNmWwHNKZFr
         n76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wW7nDkAHdnr9E6lho99qrzF6q0AQdn4I37de/4jvj+Y=;
        b=Si/2/YyE/+ZOROv8TdUdMf5ZdYIRuHQbPep1NJt68673FMkHcWDs2hkl/LixBnHfUO
         x9iRhUA/hVZNGJdCYXXAcnn/K6lnc6QlSV6bUrvlYe72am5GIiVCJmIuCSIWR65NrLo/
         h2cepj3y9n0XUMEm9mcrR7kn/6fKIdvlrampEGIjinC8ozPbLJAFHs5DE4dkYrwZIM9Y
         iKgDjz7shg5fNp/HnCmWSW6mVUopwA/J3Zo2DKgFjeUqQvLIfFfHq0Z1jffFGvJ0a8gX
         EspBDL+rvisyWokS/eepkOZ0q2CFzNG6FjHOq/Pld+uatjqNhGhlShNTwgOcY/PdEfQS
         bzgg==
X-Gm-Message-State: AOAM533xzmbKzDdk+z8RfzHJuRLfrYfvxFYovuGYG/78uneHVYRC55BW
        W386ye2teZh/J9tvC7NtiEPCXif3+8UuaQ==
X-Google-Smtp-Source: ABdhPJzluBjWTL8JFOmWMMPD3Iq5KOrHLFrxarQNuC4dE+KYcQfEpURur7w5pF6clMoVjrT6fDsuCA==
X-Received: by 2002:a02:c64a:: with SMTP id k10mr16262751jan.112.1631025649855;
        Tue, 07 Sep 2021 07:40:49 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v3sm6294956ilg.54.2021.09.07.07.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 07:40:49 -0700 (PDT)
Subject: Re: split and move block_dev.c
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210907141303.1371844-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9b4c9d9b-a881-4796-6f18-1c57efd690b6@kernel.dk>
Date:   Tue, 7 Sep 2021 08:40:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210907141303.1371844-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/21 8:13 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> block_dev.c has been mis-placed in the fs/ directory forever, and
> also contains a weird mix.  This series splits it into two files,
> and moves both of them to block.  The second week of the -rc1 window
> might be the best time to do something like this to avoid conflicts.

Agree, easier than juggling this until the next merge window.

-- 
Jens Axboe

