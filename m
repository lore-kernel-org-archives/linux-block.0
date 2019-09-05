Return-Path: <SRS0=DC0a=XA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDE5C43331
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 20:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88282206BB
	for <linux-block@archiver.kernel.org>; Thu,  5 Sep 2019 20:52:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729538AbfIEUwq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Sep 2019 16:52:46 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41284 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfIEUwq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Sep 2019 16:52:46 -0400
Received: by mail-wr1-f67.google.com with SMTP id h7so3286073wrw.8
        for <linux-block@vger.kernel.org>; Thu, 05 Sep 2019 13:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o3XAFZlSwvqRShai5GXTckpV9x85IprbqlbdmH2dFzA=;
        b=Qy3cZYbdKjTF6uDVK4GkXLrSQ3PzwHPeOVP64uw8EThX9wBNkAjM726eKLXuUmPQKj
         5pYpyHiRJvLAJWPWZo39DqY0f0jLH+IIL1U7smaHLFSDu2nh22+Y+7HnrEoSHBUc99uE
         U7cSO5E5GbOy9TRUnecwZ/Efj9WtujwHy1AbjgRzknj5KTz7xiKVdY4iM/N6FzcmD2On
         sW1fZS8Iy6qCpHMKeFFkNkcIRpo2PgG3qn+3ECnUgWPhLS+T0kjPtEcvwA2yip6R+LiX
         di2phN4WuE5+0coh6z1g1oQnYY7+2j/kSqJHvWCl47sxIY+Sug8gjgs8MJDw7zIsxINK
         dJfQ==
X-Gm-Message-State: APjAAAWZ8Ur/RT+Br02/w8fJHruY7FsegMeLCKFc/SuQ4icLn+E2iH0W
        WUQTfZwkknU59soC2ES2pUQ=
X-Google-Smtp-Source: APXvYqw7fWpSR45UDDGyicWGQaRxX1KRznOmvLRir/OHV+VwnLFzdVgSOKrCaxvdCcxcTv0bVnw8yA==
X-Received: by 2002:adf:ed42:: with SMTP id u2mr4473776wro.330.1567716764579;
        Thu, 05 Sep 2019 13:52:44 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id u18sm1988516wmj.11.2019.09.05.13.52.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Sep 2019 13:52:43 -0700 (PDT)
Subject: Re: [PATCH 3/3] nvme: remove PI values definition from NVMe subsystem
To:     Max Gurtovoy <maxg@mellanox.com>, linux-block@vger.kernel.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de
Cc:     shlomin@mellanox.com, israelr@mellanox.com
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
 <1567701836-29725-3-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <882441fc-599a-21fb-9030-5208b3b671cc@grimberg.me>
Date:   Thu, 5 Sep 2019 13:52:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1567701836-29725-3-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


> Use block layer definition instead of re-defining it with the same
> values.

The nvme_setup_rw is fine, but nvme_init_integrity gets values from
the controller id structure so I think it will be better to stick with
the enums that are referenced in the spec (even if they happen to match
the block layer values).
