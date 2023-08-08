Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E18C001B0
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 21:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbjHHVty (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 17:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbjHHVtx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 17:49:53 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4DE2108
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 14:49:52 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1bc6624623cso27367965ad.3
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 14:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691531392; x=1692136192;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=92KKdVxwqhsOOeT4H0xJZGbP3WQlvAKir+clueMQyCo=;
        b=JWm3oSW9IaX8H1Xi0sbvW1ZnQXvEThgIAcYEw0O+PDnUoNWgSsKo9EOKvMCFGsppQe
         nHQ1crGeM4kr52GqVbxwZqPFMx7pZ+BgHgKNbzYjd+hkx07tEvpvt8atVJ9v240m8QUw
         KwZ0lKqpGdPvFJSy4h9Qh1YBmNud80aqv8/RrYI8xDkMfp4UclPZ0W8tJi7kP1I6nxXH
         U8c5Q/fy8WG3w62q9Ki0Oq8o3ov1uApzSISwAKZucqlVop3VX8ZWzDnSBFMAkAETgddM
         aNeRJiZziqt5Hv+THl9gBrOOLzAR8AT/3gNPNDPVnIm+7ysyTaF1jFO9PljUxl6Sn5lY
         zU0A==
X-Gm-Message-State: AOJu0Yy6P9w4OFJjLJ2GVOZId7M7h2Eb1sAeHaaxUJuYZzEtAjZIUyFT
        MGNSBdHU80snzOKJiatVW0jZjiH60k8=
X-Google-Smtp-Source: AGHT+IFEL6xeVKlny9YZr6666FmBwVEynX3dS6few3vz/5ozvp3eWjrf/KpaZrkRzqbG7ApWkDoyMA==
X-Received: by 2002:a17:903:1252:b0:1b9:ebe9:5f01 with SMTP id u18-20020a170903125200b001b9ebe95f01mr1136411plh.19.1691531392049;
        Tue, 08 Aug 2023 14:49:52 -0700 (PDT)
Received: from ?IPV6:2600:1010:b047:2ab0:fd93:3f7d:e947:afd4? ([2600:1010:b047:2ab0:fd93:3f7d:e947:afd4])
        by smtp.gmail.com with ESMTPSA id h17-20020a170902f55100b001b864add154sm9460519plf.154.2023.08.08.14.49.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 14:49:51 -0700 (PDT)
Message-ID: <5eb9ec13-4413-6f0b-aabe-4d00a2fba6f6@acm.org>
Date:   Tue, 8 Aug 2023 14:49:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] block: get rid of unused plug->nowait flag
Content-Language: en-US
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
References: <20230808171310.112878-1-axboe@kernel.dk>
 <20230808171310.112878-2-axboe@kernel.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230808171310.112878-2-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/8/23 10:13, Jens Axboe wrote:
> This was introduced to add a plug based way of signaling nowait issues,
> but we have since moved on from that. Kill the old dead code, nobody is
> setting it anymore.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
