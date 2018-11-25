Return-Path: <SRS0=TDIO=OE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0DBC43441
	for <linux-block@archiver.kernel.org>; Sun, 25 Nov 2018 09:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 642DA20664
	for <linux-block@archiver.kernel.org>; Sun, 25 Nov 2018 09:13:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 642DA20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727292AbeKYUDk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Nov 2018 15:03:40 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:36080 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726859AbeKYUDk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Nov 2018 15:03:40 -0500
Received: by mail-pl1-f195.google.com with SMTP id y6-v6so12439176plt.3;
        Sun, 25 Nov 2018 01:13:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ijgm1T7y1Jhricp1oH1Hi+8JLJlEIeiZHTVjHbG1AOI=;
        b=ezfoG5oMm+Y+M8WWHSYYbxumhd2bDSXefexjsqZxL6RoUoMTPjnEWWE64ipFlFXwta
         vCqPsNMxmfJDvMDdLFb9KOhAq1S9VaFavftz/ciVpD5RtWR4sKI66FDFELqnMxpiq0xp
         vl20Vq6POllmoVKW+ZM+rv6Ds04aKk1I4cf7GrjX83PfVs4IphMTxXuub4IPZapp0FLE
         6DLwWVFQnnHjuz2eIDg6c6PVWJq+x/3mrABZRkxhXVCr88nAJeRGCkgjqoPobYRWYYE8
         0oZf8DuWqtAqaYJGOPK+MLXuXBSHlYSXXj4TKbxCFi5iqfK2ZSdkuez8J6YJmBXqfahS
         g4UQ==
X-Gm-Message-State: AA+aEWakSNozX9FoWVigmnClQM7QeWJ6aAIfQ4MkmdOtYuB5U0xxuhOu
        RuFMm59T+YA5kqRX29Tyy4Q=
X-Google-Smtp-Source: AFSGD/UGwOmbtiwbjmJuZrC00W3xMIB2TzBbOfHPpMq9f51r7Qk3NqYtGsJIMQXqK3V2B6HR4OB1QQ==
X-Received: by 2002:a17:902:166:: with SMTP id 93-v6mr22338270plb.68.1543137182776;
        Sun, 25 Nov 2018 01:13:02 -0800 (PST)
Received: from [172.20.8.115] ([207.8.179.17])
        by smtp.gmail.com with ESMTPSA id d16sm59159622pgj.21.2018.11.25.01.13.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Nov 2018 01:13:02 -0800 (PST)
Subject: Re: [PATCH v3 11/13] nvmet-tcp: add NVMe over TCP target driver
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        netdev@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20181122015615.15763-1-sagi@grimberg.me>
 <20181122015615.15763-12-sagi@grimberg.me> <20181122090655.GA27707@lst.de>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <4375f088-6afa-e0e6-1fdb-51359741660c@grimberg.me>
Date:   Sun, 25 Nov 2018 01:13:00 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181122090655.GA27707@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


>> +	if (!cmd || queue->state == NVMET_TCP_Q_DISCONNECTING) {
>> +		cmd = nvmet_tcp_fetch_send_command(queue);
>> +		if (unlikely(!cmd))
>> +			return 0;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_DATA_PDU) {
>> +		ret = nvmet_try_send_data_pdu(cmd);
>> +		if (ret <= 0)
>> +			goto done_send;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_DATA) {
>> +		ret = nvmet_try_send_data(cmd);
>> +		if (ret <= 0)
>> +			goto done_send;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_DDGST) {
>> +		ret = nvmet_try_send_ddgst(cmd);
>> +		if (ret <= 0)
>> +			goto done_send;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_R2T) {
>> +		ret = nvmet_try_send_r2t(cmd, last_in_batch);
>> +		if (ret <= 0)
>> +			goto done_send;
>> +	}
>> +
>> +	if (cmd->state == NVMET_TCP_SEND_RESPONSE)
>> +		ret = nvmet_try_send_response(cmd, last_in_batch);
> 
> Use a switch statement?

The intent would be such that the state would transition with
the progression of the routine...

...

The rest of the comments will be addressed in the next submission..
