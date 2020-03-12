Return-Path: <SRS0=va7b=45=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D88C2BB1D
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC203206E7
	for <linux-block@archiver.kernel.org>; Thu, 12 Mar 2020 13:55:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nP6/WLI/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbgCLNzD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Mar 2020 09:55:03 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37808 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgCLNzC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 Mar 2020 09:55:02 -0400
Received: by mail-io1-f68.google.com with SMTP id k4so5758883ior.4
        for <linux-block@vger.kernel.org>; Thu, 12 Mar 2020 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cToFEtVUE7Ch+tt4XDUBJXMv4CHtAMLqOw63rT85I/c=;
        b=nP6/WLI/WsIOf+1zptS2XUXHgM4MDLa8+uqf5HvQU7qxSsF029TVjIqbWUlDNGSAeB
         oVy9tnq6L7kjYwKWR75T3+o8lKY9GFeiuqVEx5Lz3Vt47VQ2K3BM5bYTNGslhzBp1Rrf
         kpcX+LwALPmR6rXCFCQn0/uxqseNDRfHs2bdr5KAF5Ll5vRnXMlGCmMjyIkCZ4EU+GH5
         1lwAoEsZJ9QmnMlNnX70KCh0e5eEPtictp78Kx2YmnpKQ/pO27jH6PItl0dh5iVu6gp6
         hKRue9NlzIj9ofk7oECvEjEPwe5tGUR47Xnv+XH2rBMfMevm9Zxrbj3KbitNV9vs23fy
         znuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cToFEtVUE7Ch+tt4XDUBJXMv4CHtAMLqOw63rT85I/c=;
        b=svVT5gtAtV6L/RkHFQt7ykA+SpC/UOYDc23UO4pZahJzw4MEM7h/Ch16WEyqn1J0A/
         D1RkTtgZMwRWeUT1HW5z3ZDXpukSJeHa9lMVgm+ZuTFbNEMqGovG77zq9Ao30XZPeHGu
         vLtITW+hyr/Yt9UcbChlSzpriKcnug8yPWKt1o0DBe8+z/Cxaw9KE8dyCyupqmiyg8vK
         g4Cqa2qOvdH+imsPvTfD+Xzp/DzWw6g4onLkb6KlaGSsVl5TgFZgOw5xkWbP3pR7do3f
         P7jVwIWl8inQZxrjktQCfuEzbQ0e4b3fqdEUV8FLJyNpM3R3W5juAmrR+eSSTB7LedHt
         ejOA==
X-Gm-Message-State: ANhLgQ0rZMAfwTkMo/4+7GlWfmWLNgJvOvNgCoz5k9KZ7Gtx5H7N7jR5
        9HAzrHwjGZxvoX/s5sAtJatcmz7YKWaonQ==
X-Google-Smtp-Source: ADFU+vvaAp9Y3yBZ/nmn+XwUZzrMACmfwA/BaaZfZ2bmO6Rj35fqEwpIYvKHtA62Ozr7lVRlp42Gkw==
X-Received: by 2002:a05:6638:921:: with SMTP id 1mr8293503jak.110.1584021300362;
        Thu, 12 Mar 2020 06:55:00 -0700 (PDT)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id k20sm8515402ilg.45.2020.03.12.06.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 06:54:59 -0700 (PDT)
Subject: Re: [PATCH v2] block: Fix partition support for host aware zoned
 block devices
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7bfa45fd-2ad5-be7d-b486-e778d44b3209@kernel.dk>
Date:   Thu, 12 Mar 2020 07:54:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200221013708.911698-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/20/20 6:37 PM, Shin'ichiro Kawasaki wrote:
> Commit b72053072c0b ("block: allow partitions on host aware zone
> devices") introduced the helper function disk_has_partitions() to check
> if a given disk has valid partitions. However, since this function result
> directly depends on the disk partition table length rather than the
> actual existence of valid partitions in the table, it returns true even
> after all partitions are removed from the disk. For host aware zoned
> block devices, this results in zone management support to be kept
> disabled even after removing all partitions.
> 
> Fix this by changing disk_has_partitions() to walk through the partition
> table entries and return true if and only if a valid non-zero size
> partition is found.

Applied for 5.6, thanks.

-- 
Jens Axboe

