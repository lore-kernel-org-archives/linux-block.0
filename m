Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C94C43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E63A20874
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 12:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="GnfPe3VL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbeLQM4e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 07:56:34 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:38968 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbeLQM4e (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 07:56:34 -0500
Received: by mail-pf1-f169.google.com with SMTP id c72so6338309pfc.6
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 04:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=WAvOsxiuS9YxGZAw6HQmoH00XGwkuKk8KMo0+N4HoxI=;
        b=GnfPe3VLbQLP6AlKtxp/9VnzVF1No9TOMnSyzfXvPBzXntH8l2xttbkLoXH63wCUwK
         q+cAs+PIZvStn4lNb6tkHPgh78ucNt7ikWq4kjgXw72j5dBxbOgu1phuxkqgu4/23gvA
         4F9uL2st8eoefEu8Oeb90aZ9KJLLgxLrznO1Z2QRDATTCfcGKPAxAmw42arckumm2fDo
         L3C15x8uwWXnENb/VSVWmLtI5mZEGoB3O53mTLu2q6NrN6J5QezkqdHMResYl1bL8VlQ
         tXbp01v6txocmcwPsUpCmWIKAVCS3o6oB3xgo+0q+00kRHh/tnu1FAX4BBInh7SatbJN
         v4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=WAvOsxiuS9YxGZAw6HQmoH00XGwkuKk8KMo0+N4HoxI=;
        b=Zm7QUMHvBXfe27lvkgmGLeMDFhRalPXBOVVNjL2XwCEmo7PlrU+6pfeyIgmj/YGW1e
         3IP8QmW9LZCbu9DDjRgjIivel8a676mQMFjHelzdW0ORvnBJTwtOVKlsin6Qz8coqPwh
         zfLbSj3e/JakYG6c0y4ODEkX3E4fBwKhNlmwA53EhRU+usFaap/2lafbbg9INV4cOdL3
         M1q3s0bZQy6ixIAhFbAo+YUEXu5hx4JX0RPR2onx0iybQqOaJX+MutFMBo+S36cEv8/5
         /x7JbFykmJy2PgwPm5XyHYyAWhFssciCItxDnrRL79XEEpPMb/TOqeKg13YX24mNZNT0
         VfGw==
X-Gm-Message-State: AA+aEWYY4iJlRdXGdMv6Aea8DMEgN1RY3qJNTRKocAjp0rhYya6tNqDK
        vC/mcuZe9GaG+6+RkljgZ4FzJQ==
X-Google-Smtp-Source: AFSGD/VnkO6BEsJT9Y7vfjbtClLWBf7/7+JY8fiFeuIDea3FbCtkOXkLZEtQKcqh6vOpQWyCMDOKbQ==
X-Received: by 2002:a63:1d59:: with SMTP id d25mr12285368pgm.180.1545051394002;
        Mon, 17 Dec 2018 04:56:34 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u87sm30300227pfi.2.2018.12.17.04.56.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 04:56:33 -0800 (PST)
Subject: Re: [PATCH 2/2] nvme-pci: don't share queue maps
To:     Christoph Hellwig <hch@lst.de>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <20181217111627.22635-1-hch@lst.de>
 <20181217111627.22635-2-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <158707fb-7fb4-ac6f-a118-dd9892f3da36@kernel.dk>
Date:   Mon, 17 Dec 2018 05:56:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181217111627.22635-2-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 4:16 AM, Christoph Hellwig wrote:
> Now that the block layer checks if a queue map has any queues inside
> it there is no more reason to duplicate the maps for the non-default
> types.

Applied, thanks.

-- 
Jens Axboe

