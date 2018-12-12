Return-Path: <SRS0=4xS2=OV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F4CC67839
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E41D2084E
	for <linux-block@archiver.kernel.org>; Wed, 12 Dec 2018 00:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E41D2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeLLA1J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Dec 2018 19:27:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40428 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLLA1J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Dec 2018 19:27:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id p4so15918689wrt.7;
        Tue, 11 Dec 2018 16:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1TR0iMQI7QbQK7SnVahtfZS7l0lciltd4amSiRM6Okc=;
        b=gjhmG8IQQnTyu9j427xuJ8BSGmuOXOPidDcgK3lDMT92eIql3EGM2sGpEbVhOdpLHs
         oSYS1e5UyclqmWYs4XsJwBFLkQiSC5lMOu8LU9yOuARir6Y9aOHnAJRkpOzc18LxK8GP
         XzT1PBTm+wUnMZw0yDSLc/mOG5tHGJehSULz+hCMDM7ZRA3L9eePzv3zitWdJPzku94s
         NhU+X+asi3TSoZUU2f3so1L6CxQYID1fWtfS6m60GN7aTE3B/0a6hdWnQZjw31uVScyn
         jHNv3cUQCPCFhrK//6biUmKyeZ9Wj+s72RhI02dTvcnENB7Y/oNAgHMoQI56VhpQNOt3
         PU9A==
X-Gm-Message-State: AA+aEWbp4a4URXhYLVQX6ChLqMTEI+fzIsYR/LET87oxxo33XTPCpoX6
        gWL1bDNBxEKq8+yPVrHlj5igrKmo
X-Google-Smtp-Source: AFSGD/WTydRITfd8x7LiPHcdnIEtEmpLbh0Fmcsyz0M0vg46sRoMHmEfG8SizfXugOPsRF35zOyidA==
X-Received: by 2002:a5d:5649:: with SMTP id j9mr15125550wrw.256.1544574427905;
        Tue, 11 Dec 2018 16:27:07 -0800 (PST)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id h62sm1269152wmf.11.2018.12.11.16.27.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 16:27:07 -0800 (PST)
Subject: Re: [PATCH RFC nvme-cli 5/4] fabrics: pass in number of polling
 queues
From:   Sagi Grimberg <sagi@grimberg.me>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20181211233652.9705-1-sagi@grimberg.me>
 <20181211233652.9705-6-sagi@grimberg.me>
Message-ID: <c9701768-08db-6793-c31b-37ca17c404e4@grimberg.me>
Date:   Tue, 11 Dec 2018 16:27:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211233652.9705-6-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> +		{"nr-poll-queues",  'W', "LIST", CFG_INT, &cfg.nr_poll_queues,    required_argument, "number of poll queues to use (default 0)" },

Oops, this should be 'P'
