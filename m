Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D49C433F5
	for <linux-block@archiver.kernel.org>; Fri,  1 Apr 2022 23:56:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352720AbiDAX6f (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Apr 2022 19:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347303AbiDAX6f (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Apr 2022 19:58:35 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087D11F0CAA
        for <linux-block@vger.kernel.org>; Fri,  1 Apr 2022 16:56:44 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id s11so3955555pfu.13
        for <linux-block@vger.kernel.org>; Fri, 01 Apr 2022 16:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=VQ+/LXmZBpLsFWJ/iYBd7+wR3oEOq8NpUsezc2JIIDw=;
        b=nELgAlV6Vv2GxUEc8WOyDjluNtKh3pCKw9l+sXlrNhWtxWpRQnlCpoYKbdUTvQH9Lr
         AuOGkrI3yUsyH7dvAa75ZRAev2JfkpPm1AnVB+MJ3PvPXUybjOcbCeH7YjOe8d3fKjHQ
         bvgiZgtaVO9eMdk3nIcXnBh1XDU5Od2gdyP1m31xyY66hXq2Cf0CpRUV16BBIXoe/4xx
         TIWAKclzDrq6q8CQdHnv/ByYsF345EJzjT/NIkwH0KD8db33UVuSj8wLjArH1pImZDNB
         VhbvEsbNvko4CbsDZOkBEB6aK9jODfJvr/eQx1DfdZ2R4CctWHceZhMi2SZvHwitnn9X
         AwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=VQ+/LXmZBpLsFWJ/iYBd7+wR3oEOq8NpUsezc2JIIDw=;
        b=iOTUSENbmW0Ef6pio4tKHgNihBLJJAOzZmKbvJHxYEIMG7/xbvtI+9PUlHmq3y/tfa
         7+rb5BJ5U0HgKhvFe1xhU0pXCSuB1eQFaMWf7olJd5sorOoP6hHXudS+HWMf0SUy9v0/
         KeytlBny0csysz76+wN6udbdIhQYlh86GCKZt0W1W9e5HQ/Bq7gwpmJ+166PuzettQFR
         PhOH0Wqon8r+6Yf0mhqUQjceng7xqa+XZhfbh4eCduqg0uW29CMRYup/L1LZ6iB2FmRn
         OIGDiCDl7zaJqEs6IK7G1rO4vMZtCv8nNTNfIDlzN17bUovel9sMzCDELERWuAIgrIDA
         3eUg==
X-Gm-Message-State: AOAM532iotMxWm6D3U0S9e6kQeIoA+lE9ZsIKUuOfZR19R4xQ+8my+9Z
        zjE/ZVuynCbGlUZ8O+YyyLshvg==
X-Google-Smtp-Source: ABdhPJyjW8TjDgz0OTj7QB9ER5R991hyLy8Kyoztyj4/dY+4JL34juigk8KO2prtyD4tQpPRf+hD/g==
X-Received: by 2002:a05:6a00:234f:b0:4f6:f0c0:ec68 with SMTP id j15-20020a056a00234f00b004f6f0c0ec68mr13549033pfj.14.1648857403369;
        Fri, 01 Apr 2022 16:56:43 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v189-20020a622fc6000000b004fb72e95806sm4044187pfv.48.2022.04.01.16.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 16:56:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Philipp Reisner <philipp.reisner@linbit.com>,
        Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Bos, H.J." <h.j.bos@vu.nl>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>
In-Reply-To: <20220331220349.885126-1-jakobkoschel@gmail.com>
References: <20220331220349.885126-1-jakobkoschel@gmail.com>
Subject: Re: [PATCH 1/2] drbd: remove usage of list iterator variable after loop for list_for_each_entry_safe_from()
Message-Id: <164885740219.761778.5044909883791536138.b4-ty@kernel.dk>
Date:   Fri, 01 Apr 2022 17:56:42 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 1 Apr 2022 00:03:48 +0200, Jakob Koschel wrote:
> In preparation to limit the scope of a list iterator to the list
> traversal loop, use a dedicated pointer to iterate through the list [1].
> 
> Since that variable should not be used past the loop iteration, a
> separate variable is used to 'remember the current location within the
> loop'.
> 
> [...]

Applied, thanks!

[1/2] drbd: remove usage of list iterator variable after loop for list_for_each_entry_safe_from()
      commit: 901aeda62efa21f2eae937bccb71b49ae531be06
[2/2] drbd: remove check of list iterator against head past the loop body
      commit: 2651ee5ae43241831ca63d7158bb2b151a6a0e1f

Best regards,
-- 
Jens Axboe


