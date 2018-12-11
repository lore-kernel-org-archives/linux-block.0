Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE8AC6783B
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F6132086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 23:34:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F6132086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726357AbeLKXed (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 18:34:33 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33946 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbeLKXec (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 18:34:32 -0500
Received: by mail-oi1-f195.google.com with SMTP id h25so13583202oig.1
        for <linux-block@vger.kernel.org>; Tue, 11 Dec 2018 15:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yafPJnl+PdOgvyoRVag2vuSqK645F4OR2nW/M0tDJ4k=;
        b=qOoMmW4TscsjTu9ldvgJgnZDQfXemfhAcOCZrr3ZbjzjR3gZs4zOhf5WhFgykm1soM
         egI7h+CJPtVxJ4QSmdGNbp1tq+/TH1cCCd5DAYomofbcKHrVraO/eBOwPIl7aLQywHWn
         s9V7uS5xirK8qJyt9G/FVmWaEPY8f1jIvFlSIht6r+VXBd5nO1FUFpT4389HKRf0gooF
         df3KfWUuY57ydvtUTrnM+6XvYbk+5bvJWXQfWyp5CMrAUnmTOkMDWuqidP3w29EDwAny
         pOwW+nAuRm0SPFOCatNSMaBytBigLA1GRK+5ip+zr1xFBj4mjNne/4eMerMvVLUnOUOy
         UB7Q==
X-Gm-Message-State: AA+aEWYC5WWOEo+e32svjssBlba/O4ELSUWT6pgGEaGX7FlIyhLq9D0M
        XdU2tXddsWqRpS99Aw2z9+siAI5L
X-Google-Smtp-Source: AFSGD/U9I68/ZBDT/53+4HU4tx9kJc0ymuGEa46uxcC5dAGM9lw56HkmX5+oeqGbxG6LmpsHYHCJKw==
X-Received: by 2002:aca:2803:: with SMTP id 3mr2558548oix.85.1544571271886;
        Tue, 11 Dec 2018 15:34:31 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id s186sm7399141oif.0.2018.12.11.15.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 15:34:31 -0800 (PST)
Subject: Re: [PATCH nvme-cli 6/5] fabrics: pass in nr_write_queues
To:     Keith Busch <keith.busch@intel.com>
Cc:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
References: <20181211104936.25333-1-sagi@grimberg.me>
 <20181211104936.25333-7-sagi@grimberg.me>
 <20181211193015.GC8101@localhost.localdomain>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <45d197ee-9f2e-ab65-4927-f8f7308395d3@grimberg.me>
Date:   Tue, 11 Dec 2018 15:34:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211193015.GC8101@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> On Tue, Dec 11, 2018 at 02:49:36AM -0800, Sagi Grimberg wrote:
>>   	if (cfg.host_traddr) {
>>   		len = sprintf(p, ",host_traddr=%s", cfg.host_traddr);
>>   		if (len < 0)
>> @@ -1009,6 +1019,7 @@ int connect(const char *desc, int argc, char **argv)
>>   		{"hostnqn",         'q', "LIST", CFG_STRING, &cfg.hostnqn,         required_argument, "user-defined hostnqn" },
>>   		{"hostid",          'I', "LIST", CFG_STRING, &cfg.hostid,      required_argument, "user-defined hostid (if default not used)"},
>>   		{"nr-io-queues",    'i', "LIST", CFG_INT, &cfg.nr_io_queues,    required_argument, "number of io queues to use (default is core count)" },
>> +		{"nr_write_queues",  'W', "LIST", CFG_INT, &cfg.nr_write_queues,    required_argument, "number of write queues to use (default 0)" },
> 
> I realize the kernel's nvme-admin uses "_", but everything else in the
> shell utility here uses "-", so just want to use that for consistency.
> And the documentation needs to include this as well.

Will do.
