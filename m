Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF3BC433FE
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 19:50:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245158AbiCGTv3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 14:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239466AbiCGTv2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 14:51:28 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F62589324
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 11:50:33 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id r11so13738138ioh.10
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 11:50:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=075g20k4DHefJxD6reM7eLorGBY2V+lTaMr5/Yfuikk=;
        b=b6gizO6iwcc+5TmuZFQ+HaG1IufNjOIurkziuVpMjRnJkz0C7OfK1K50nDahz+v7Ll
         UHwGuQaLB00rzfRu4UkOpJ6wWJb1nP1ftxPZ5xpdPKXaIPBbfVNygA4ILoYup/9NuSAN
         bXqiod4vVT+LgnaOXLEeCU5i4s6TWyPRv5hnEHmxN730zF+CaiTefhnkDCVzATTIPDiQ
         54Fy1Un6SCWLdyr4UFngqVDJUAk90q5bi7qKp7BOVNrLrGgVdW+4Z5Q+ghqdMfirjnlp
         eLLeruOIQLu08sWXcpYj6ZIdMgWcWZ2OhLeuvm9LfhJdecKBcNy4CYO2tHNBqR9z5FZo
         yF7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=075g20k4DHefJxD6reM7eLorGBY2V+lTaMr5/Yfuikk=;
        b=M8cOLJkL2jJiJtsvgHlY6VWsHlifTkJ1Pz6SUDRJuCR4OHWVTqotoiyQRNPpSjpUXV
         GUNx3Bb5wlYtSlJteHNLFaTW5v6DxDcqk3RDAHt3irQ/JBqzVOwMnEvSUDilXWm+ky8/
         6lsRulLgEBI1ZqiTCrH7J9D9joXyelpOtTd8w1rblo7TY+DxHCq0J88elQj0BgeDcNAo
         Ii5fFDbeBQHGx3UsFPBNFy8buOJCZ/eTS7XBi1tZnCSwkkjNeqXPcohPXwE5OSvsNmjw
         W90wddjLaZXQdhDOCwefHCN/BiZk73Wj/kOQM5vCN8eNhlSPkEZG9RPZc9aruh9xc8MX
         Kyvg==
X-Gm-Message-State: AOAM53089KGXPdIX0qK0nzLK1Hu2iV11yPfdcT+blOeO7n503109TwRr
        LP5VHl7SWVkuanCTZKxnMBEZqg==
X-Google-Smtp-Source: ABdhPJz3EJTLTGdE09CoWJ3Zw3rYFrvaaiC7ejcGBa1FivbI69Gj/+t2treGBX0dGrzg2icD+cfxnw==
X-Received: by 2002:a05:6638:1693:b0:317:aa11:16b with SMTP id f19-20020a056638169300b00317aa11016bmr10953735jat.125.1646682632627;
        Mon, 07 Mar 2022 11:50:32 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id h28-20020a056e021d9c00b002c64c557eaasm1187521ila.12.2022.03.07.11.50.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 11:50:32 -0800 (PST)
Message-ID: <f059aa4c-5af0-c3ee-12f9-1b19b2b380aa@kernel.dk>
Date:   Mon, 7 Mar 2022 12:50:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCHv4 0/8] 64-bit data integrity field support
Content-Language: en-US
To:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     hch@lst.de, martin.petersen@oracle.com
References: <20220303201312.3255347-1-kbusch@kernel.org>
 <20220307193448.GC3260574@dhcp-10-100-145-180.wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220307193448.GC3260574@dhcp-10-100-145-180.wdc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 12:34 PM, Keith Busch wrote:
> Hi Jens,
> 
> I believe this is looking ready at this point. Would it be too ambitious
> to see this applied ahead of 5.18? The block layer provides the focal
> point for new capabilities in this series, so I feel it should go
> through that tree if you're okay with this.

Layered it on top of the write-streams changes to avoid a silly
conflict.

-- 
Jens Axboe

