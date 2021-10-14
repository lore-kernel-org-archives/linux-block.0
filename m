Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC11C433EF
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96E9D60E0C
	for <linux-block@archiver.kernel.org>; Thu, 14 Oct 2021 15:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhJNPOO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Oct 2021 11:14:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhJNPOE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Oct 2021 11:14:04 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B005AC06136B
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:07:39 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id i11so3817917ila.12
        for <linux-block@vger.kernel.org>; Thu, 14 Oct 2021 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SfJyXvRKhjtS0cyhrXF03/tm4IHT9n76BF2F5ZJ0mLM=;
        b=63SgkVEVxlJJbLeYFQziy19tPIXplozPNML5kfLIXNs6YRiGgFBBD3dRDj1J5b9CFJ
         e5w0LwRUaGXRKdGDAsGxVw1ZMHWSsWQCDfiqKU2n+knjeYra8i1ROa37Xss4gAg1SVZi
         t0X1HEoMAeO1brtYgdHzSbCX0PFNqEgdZyHL9WJ7YJbGznalJVPxTLdgEVh+nQBTNKhr
         CVtemTh6TSwEQc38JVq6N+xCjGoN/O7Ef7zz3u02n0p9Knjws7oxPQCsc5tLJU7M6Hdw
         CMVQi2ygZ5xv/B3D9fNdGzt91Uj6xqhNlmCLR6eYhbITAjCQn4w+Pp++aeqjEyxKdTtF
         dlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SfJyXvRKhjtS0cyhrXF03/tm4IHT9n76BF2F5ZJ0mLM=;
        b=J7Ge3VMA7W4v3O3FoNzIq2NCMKoSuDQpEMvsrjwmaQfX+jgUGaH9rpq/GaESzQfpfM
         CKA7/4Yyh6iMkqCB2JvARwQ0OX4O07u/3KJ/L9BrKIsPCe5k7iOQ+kkLp31MaK6caoko
         76eKIlGC1Tzw0yjqjCOrJ7aHscqF59KmAXDE4VbS5FRzZ0TUWjeFacG/YpdTJQaY27yo
         OI1QYRSs7JnNUl4IVh5R4ybsIlbt5GvEF7D0YybznbVs40tRoAEF+1HKvlmCJ+0E3GeH
         zTmD1HhXlFGMnACy6SgxcLbCEBgA20lw+JL8+K+G0jCBZ9077oea8E0zo2y2s/t5QAws
         KacA==
X-Gm-Message-State: AOAM530OECNeibcgakW3deBD4ht7FudscsjcE5VyDj4OX7fwA8ixOe6P
        DRdL81r+hi1zSJswZt2+cWQECIUq3TYmsg==
X-Google-Smtp-Source: ABdhPJxdB4ieGCBY+L04nlT2giJ1T7Gt6iBQIwYTJx1PW7z0qeSZzOhwM5nr6LUuVtYSXEDy6CoO5g==
X-Received: by 2002:a92:2c0d:: with SMTP id t13mr2799365ile.99.1634224059075;
        Thu, 14 Oct 2021 08:07:39 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id ay5sm1486566iob.46.2021.10.14.08.07.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 08:07:38 -0700 (PDT)
Subject: Re: [GIT PULL] nvme fixes for Linux 5.15
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YWgrK/7ttndn93Fx@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b77904e4-7a20-fe98-55e2-b211d2217553@kernel.dk>
Date:   Thu, 14 Oct 2021 09:07:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YWgrK/7ttndn93Fx@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/14/21 7:05 AM, Christoph Hellwig wrote:
> The following changes since commit 298ba0e3d4af539cc37f982d4c011a0f07fca48c:
> 
>   nvme: keep ctrl->namespaces ordered (2021-09-21 09:17:15 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.15-2021-10-14

Pulled, thanks.

-- 
Jens Axboe

