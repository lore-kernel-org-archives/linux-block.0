Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50DCC433EF
	for <linux-block@archiver.kernel.org>; Sat,  9 Apr 2022 02:28:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbiDICad (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Apr 2022 22:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiDICab (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Apr 2022 22:30:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF83C53A5C
        for <linux-block@vger.kernel.org>; Fri,  8 Apr 2022 19:28:24 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx5so10234877pjb.3
        for <linux-block@vger.kernel.org>; Fri, 08 Apr 2022 19:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=aP/uEaYpsHrJ8Gy8ffXu+nyzx0P9m+j2gLhkvWYNHO8=;
        b=FixpIaCvf2/5FS8G5XpQa4vwIkx44LKaD0JlnAtR18K43rkynRPe2QhPtdq60IfH/v
         SgDblxwh6K4UlulMSOy8Z30ZttqI74PNtO3KfVpdu0RZGoG3DjKj+WHGFzzCHr9cXZC4
         w177gBQfMZ/Y2nVN0DDpnXLbmEm/Y9IpbtEzp/7fEEYwwvDN21iTDhJivZnmt+UJHlIe
         fsFPhSh55OhtbyIHi5ksO7cAluBnD3F1Bje3Ve/Jqcy6TuoX1oVMeXh6v8buefZln/ob
         GTUX86LDkxRSdwvM7q2paH8oy87yW2/mdG8L83UPrFrjV59lAGzWnrCRvvvU9zR5woxC
         Xfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=aP/uEaYpsHrJ8Gy8ffXu+nyzx0P9m+j2gLhkvWYNHO8=;
        b=1EF6cz6bU5Ysiv1SUS69Z0y0aaQCtBXIVGs/MW0dgjdLNMS5EKhYo4MX/1m9fveRxs
         vgUCKwgxkObTvMwif6vos8B075Q9WyoLBTbMGwMe9W+vuxtHvbKYl8LlOUJP7HFwhyms
         2zQgh4d1PVYUoY6MrBsyYO+3e9qN0+qNbrXnaa/HjcGkEHwKAR2t4hQ/YWruOTkRVZb6
         ijs2gewbtC8vZWmGPczTf9rGRyF1tt9ytDLeCNv72e4soa6fUngsfqgYC8Gb9WlTy2vq
         5xzSrQwW4pOmtiV1Vi4y1pzufZEsQvDkYMRs+vEgP1PLpr/23dEoRQq9MpIaL9H4AvuA
         IO7g==
X-Gm-Message-State: AOAM531I9Hh5B4P902Az8fHaIzZdznnlwK96gv8Ik/CIMCDL0A5yEp9r
        Y4/+Adn7WLIoVERC145/g53n0A==
X-Google-Smtp-Source: ABdhPJy+TzZDF9jQhI5qKF0oImy73TjPXXrrcmBng8ALso07xGqsuiiwEtDc9mXlAxmM0sC1q1xdvA==
X-Received: by 2002:a17:902:c643:b0:156:b53e:60e1 with SMTP id s3-20020a170902c64300b00156b53e60e1mr22428468pls.43.1649471304208;
        Fri, 08 Apr 2022 19:28:24 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y6-20020a17090a154600b001cb59d912f1sm1255901pja.13.2022.04.08.19.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 19:28:23 -0700 (PDT)
Message-ID: <98d3b9b9-1786-837c-d316-cc991305c8aa@kernel.dk>
Date:   Fri, 8 Apr 2022 20:28:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH -next RFC v2 0/8] improve tag allocation under heavy load
Content-Language: en-US
To:     "yukuai (C)" <yukuai3@huawei.com>,
        andriy.shevchenko@linux.intel.com, john.garry@huawei.com,
        ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com
References: <20220408073916.1428590-1-yukuai3@huawei.com>
 <d50a0ee1-c7e2-1b99-8d3f-ce2edeea92cd@kernel.dk>
 <d02f416f-a1de-f7d9-881e-a88c1bdd25c1@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <d02f416f-a1de-f7d9-881e-a88c1bdd25c1@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/8/22 8:26 PM, yukuai (C) wrote:
> 在 2022/04/09 3:10, Jens Axboe 写道:
>> For this one, and other patches you send, they send up in spam because
>> the sender can't be verified. I would encourage you to figure out what
>> is going wrong here, because a lot of your patches end up getting
>> dropped or missed because of it.
>>
> 
> Hi,
> 
> Thanks for your notice, however, I have no clue what is going on right
> now. I'll look for some help and hopefully that can be fixed.

The easiest is probably to try and send patches to a gmail account. If
you don't have one, just create one. That will help you see the issue
and verify whatever the fix might be. It might be a company email
server issue, hower.

-- 
Jens Axboe

