Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92569C7EE2A
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 07:55:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbjEWHzj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 03:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbjEWHzE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 03:55:04 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34CC1B0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:54:41 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AA4C53F22B
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 07:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684828448;
        bh=2vdfEhfEbhGKToEgGCpfJjjBo5+jZgZhhMio7IC1pec=;
        h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type;
        b=I/o4Z7VpJhmk+AZ7sy/TPlfOxhtheQFD0kYTZC9nHGSmDafKRq190cbQSHLdSiDql
         wdjRIISQfQpIUW4nMX8l0s7ArauDG7h0OReiedHUhYzfwZNVMQsQeZlNkT0sX9rP5k
         nfRDKBo6KVRCiD4apH0o0QC0oKxNEexAXH+y4ceaTjFdKbBgdPk9knUDaTNDVYFKuQ
         ToYukhzP4RVZCHVwctPr+/R8/qWY2NYLonh/hxtz583J2lUybQwqrB30LW5WR7QJJn
         /tWMFUItyA6+/TTxDJSvKCaFHzUfn0Mnk9ZJM8O712E/pPU/xvIUCoT6l0DJOqhZ4C
         wdund7diVD3YA==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-50bcd245040so778685a12.0
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 00:54:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684828448; x=1687420448;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2vdfEhfEbhGKToEgGCpfJjjBo5+jZgZhhMio7IC1pec=;
        b=Z+uWor0mb2BtfW+JMRIww9LhkYrvQ7RjlqaCPzDSrsX/+sY+9A3yh8nVz/FQnse7AI
         utlIwQUR13BCVibHe3934z7J++jsduv3feYb19Q+SDyVSNX3GzcYFBj98qTb3XUOTUnw
         GweK1Pu6y6IOBneSqMp98mlB4C5ML0vc6tD6wU0yofiq//yQIpWR/glAs6UCnAqIH4hr
         f4yAAhBmu2snKuW4WAL4ojfBmocNcWffP75KIDF/zhhgZB70Eu74iz+ov+8hdopuKIw2
         5PrqYDz7H0plV/aKP5ZkOEspXxyI2O+ru/RAi3Qavh00REGzBr33rHT5ue9WJLKUy/Sg
         ec+A==
X-Gm-Message-State: AC+VfDwZc30u76HSFW0h++f85mL3sydAc2d9KufJDB8sOg/+mOWQ6ziK
        ajFB6bVFbmrDF8CmBERN+dSBabTmd6ZQJLMnGaNi2SNr0wQwb4jR8j8yVxXWSkpwaYJ98AK7QNQ
        dYv3o1kM6VI5N6OAF+WULNv9oEIQtLzOsSmjb86S+
X-Received: by 2002:aa7:c387:0:b0:50b:fb85:8608 with SMTP id k7-20020aa7c387000000b0050bfb858608mr9512195edq.25.1684828448235;
        Tue, 23 May 2023 00:54:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ614T5qd3IOAYDd+hKdw79g7t/FzO5vlLLmvpMnQIMxNWV1Fe70N74Ytv61sx4QHR7rblD++g==
X-Received: by 2002:aa7:c387:0:b0:50b:fb85:8608 with SMTP id k7-20020aa7c387000000b0050bfb858608mr9512191edq.25.1684828447974;
        Tue, 23 May 2023 00:54:07 -0700 (PDT)
Received: from [172.16.80.41] (10.238.129.77.rev.sfr.net. [77.129.238.10])
        by smtp.gmail.com with ESMTPSA id k3-20020aa7d8c3000000b0050bfc4a9020sm3830973eds.38.2023.05.23.00.54.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 00:54:07 -0700 (PDT)
Message-ID: <f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com>
Date:   Tue, 23 May 2023 09:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-efi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Bungert <daniel.bungert@canonical.com>,
        Olivier Gayot <olivier.gayot@canonical.com>
From:   Olivier Gayot <olivier.gayot@canonical.com>
Subject: [PATCH v2 0/1] block: fix conversion of GPT partition name to 7-bit
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Davidlohr,

This is a no-change resubmission of a patch that I originally sent to
LKML without CC-ing the relevant subsystem maintainers:

https://lore.kernel.org/all/4ae6d363-2f9b-5028-db1a-061b6f1e8fbe@canonical.com/

I apologize for the oversight in my previous submission. 

--

While investigating a userspace issue, we noticed that the PARTNAME udev
property for GPT partitions is not always valid ASCII / UTF-8.

The value of the PARTNAME property for GPT partitions is initially set
by the kernel using the utf16_le_to_7bit function.

This function does a very basic conversion from UTF-16 to 7-bit ASCII by
dropping the first byte of each UTF-16 character and replacing the
remaining byte by "!" if it is not printable.

Essentially, it means that characters outside the ASCII range get
"converted" to other characters which are unrelated. Using this function
for data that is presented in userspace feels questionable and using a
proper conversion to UTF-8 would probably be preferable. However, the
patch attached does not attempt to change this design.

The patch attached actually addresses an implementation issue in the
utf16_le_to_7bit function, which causes the output of the function to
not always be valid 7-bit ASCII.

Olivier Gayot (1):
  block: fix conversion of GPT partition name to 7-bit ASCII

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Olivier
