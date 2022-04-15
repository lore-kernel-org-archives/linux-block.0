Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52074C433EF
	for <linux-block@archiver.kernel.org>; Fri, 15 Apr 2022 12:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353690AbiDOMpD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Apr 2022 08:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351470AbiDOMpC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Apr 2022 08:45:02 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 084FF2FE5D
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 05:42:35 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id r66so7218428pgr.3
        for <linux-block@vger.kernel.org>; Fri, 15 Apr 2022 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=peJOBAzyELUA+eJW2CaLPpxXStOF2/vR/8tGmrIYhno=;
        b=WrFKLOJjZueLFfLyl7irFCF4wt5iJ/JmX5dwJXm1/gfJOBrQbY/0UMuoWDtG5G50wr
         N02wue5vBJUWTP7XwQSi7yxBTFNHTULPaeF78yPSbnwtxdWRj3KU4os2g7IPEZPpI55R
         ZU1kfX73J0mJjNZCZFHXv/t2W+oIxr9HGksvOqDafkJZDLWVp5sh6kkxxx+8EP0BnIgx
         JM8Ef0yunHCgeKuoIcZu6PsX+KC8QJu2RZCSGukozqQ9JsOorgYmFTV2GuY8M+UPTuQ5
         J5SCVIAqBhYZzpca8E7WsUXBgToMO1qCFkoMIyIVcAsY6LWFHKQFgKCUQfTpjgzjWRhU
         u1XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=peJOBAzyELUA+eJW2CaLPpxXStOF2/vR/8tGmrIYhno=;
        b=eTmxQU6QfhCsfHymCOffTltysn1L9EujVYZ233OsuF9IRKLco1ahrxGM2Tn7k0n+xl
         OD5/tCXL6k9coHvCHZwqNQNw/+5CtqApH8+7fCNfeQlHbbZ5Ilql/crgOU0wdThgYDGn
         GLLg/oaRjNAVPWsP9vrKWlJJp6kI6oO1NXwgDOsWiahYFMoJRYJMieEs45yO7oB1QOgg
         dqwGlqd0DHyEnyV1wYCRHLTd9YD8tVytSu0HYbmLQkGWU6zbNKJksN72MuqoqlZ7k404
         GMhHOKVYKYZGLX4dE9w8AEEKN9ngIaALu2gXwiCi/1xaoCvQj0E8nWAKtst6VnJRoVML
         wWeQ==
X-Gm-Message-State: AOAM531QdAhttz4Y0mvkF9iHk9SSYwnfKN7DoWrpDEtvJr/xW0bSg22S
        6EQDNW/Dg34X/UDq+orZWMrHYrLAtHDRDQ==
X-Google-Smtp-Source: ABdhPJxzoPsKR/V8rUz8WRRu+djqgxlPZDrIF7t33NfXDxQta9+iePdf8XoSXp5PiohqXVey/h3g6w==
X-Received: by 2002:a63:c13:0:b0:39c:c530:7382 with SMTP id b19-20020a630c13000000b0039cc5307382mr6341703pgl.205.1650026554195;
        Fri, 15 Apr 2022 05:42:34 -0700 (PDT)
Received: from [127.0.1.1] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm2881770pfj.146.2022.04.15.05.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:42:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220323163815.1526998-1-hch@lst.de>
References: <20220323163815.1526998-1-hch@lst.de>
Subject: Re: [PATCH] block: don't print I/O error warning for dead disks
Message-Id: <165002655342.10571.8036959782313765526.b4-ty@kernel.dk>
Date:   Fri, 15 Apr 2022 06:42:33 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 23 Mar 2022 17:38:15 +0100, Christoph Hellwig wrote:
> When a disk has been marked dead, don't print warnings for I/O errors
> as they are very much expected.
> 
> 

Applied, thanks!

[1/1] block: don't print I/O error warning for dead disks
      commit: 3d973a76e54c30772e72128ab0552ca75e588893

Best regards,
-- 
Jens Axboe


