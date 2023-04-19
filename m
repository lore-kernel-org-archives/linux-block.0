Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22548C6FD18
	for <linux-block@archiver.kernel.org>; Wed, 19 Apr 2023 20:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjDSUHc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Apr 2023 16:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjDSUHb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Apr 2023 16:07:31 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8EF4C1F
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 13:07:30 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-63b9f00640eso61037b3a.0
        for <linux-block@vger.kernel.org>; Wed, 19 Apr 2023 13:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681934850; x=1684526850;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ql/mIX5EC7c0qA+Gp1vHTF9esRXnCIxN6o05humPPeY=;
        b=wKrd446etBofls3Gl8hRiA27YFvCbWNQelRR4UP5Um+vhyoXPnHQcR4u5WNelMrDOs
         hijGsBN4bQcw7yv+SminGzD5Oso33+kK/qmYTnVbY++CK6XDOeClPhoqavVOHxNsCDXB
         CTqd0vxONYBVdL/DjODgVfr9ynROzcCHHsgjA4Qt3m5ePKZi/vb9r29pxzzXcYu08Ipn
         AsHF3ptuS16E7dVY7gOUtifaOwdwdyhO93hbBLJebhLG7xE6cF5TMR53DdLLScLQcPJB
         n6AwAHcvnqbmtCxbfB+ApDJNiTgdm5AXHknC2AMhebkDYr6ukEPvGm+ISdd4mY1lwQsq
         PR0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681934850; x=1684526850;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ql/mIX5EC7c0qA+Gp1vHTF9esRXnCIxN6o05humPPeY=;
        b=eVlBwC593VfRu0v+QOaVcgZ2b3OdE0WSY86Lxi5+XmY22scvMulNdhwmlN9oC+0tck
         ld/q7guXPdXagZZAIZqpUE95PrFzaTBRtfEQ74JB2xs7vQkZdn8I+Yw/Z9XS8rLL4900
         N39a1uEyEoS65I9+XBKjh2iGTmTHeIhtu/D2IYQ++Qr6n9KrQjci5efwNF7/MMuAnkKs
         gRDcV65JSneh0ycr4ll9O6SpoC1L08rqaMIL8sqnvgqm9ifwn97aoj+dFqaMINVMN3x4
         JVsKaCuTuyHg4gMtdN8x5vXPEgqcAhuq47G39FtdG21zXpLBR7LqAZmVMXAf0URffQeX
         Xxcw==
X-Gm-Message-State: AAQBX9e8QwfRY3P7ROjqwXtfN09YlyC4zsEIWYJwQ0TsQjVizf7NQL8o
        uJD8thhQxtiqgxWeD9amUnTdmw==
X-Google-Smtp-Source: AKy350Z7SprBH1qzNM884bq8fR5+WiYN5R3W5MpYW5Io6zh11OWNuGiCN0/Yk7vtpnY4MM1Eq6Afjw==
X-Received: by 2002:a05:6a20:440d:b0:dd:dfe4:f06a with SMTP id ce13-20020a056a20440d00b000dddfe4f06amr22516082pzb.3.1681934849752;
        Wed, 19 Apr 2023 13:07:29 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id a15-20020a63d20f000000b0051b7e3546acsm8374551pgg.22.2023.04.19.13.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 13:07:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, Ondrej Kozina <okozina@redhat.com>
Cc:     bluca@debian.org, gmazyland@gmail.com, hch@infradead.org,
        brauner@kernel.org, jonathan.derrick@linux.dev
In-Reply-To: <20230411090931.9193-1-okozina@redhat.com>
References: <20230406131934.340155-1-okozina@redhat.com>
 <20230411090931.9193-1-okozina@redhat.com>
Subject: Re: [PATCH v2 0/1] sed-opal: geometry feature reporting command
Message-Id: <168193484891.629861.17751750298839245030.b4-ty@kernel.dk>
Date:   Wed, 19 Apr 2023 14:07:28 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 11 Apr 2023 11:09:30 +0200, Ondrej Kozina wrote:
> While further testing various OPAL drives we have discovered that
> some drives may impose alignment requirements that can not be
> satisfied without reading some aditional parameters reported
> by sed-opal iface.
> 
> We used to stick to physical block size reported by general block
> device in place of LogicalBlockSize as reported by opal 'geometry',
> but at least 2 aditional restrictions can not be easily mapped to
> anything currently reported by block layer.
> 
> [...]

Applied, thanks!

[1/1] sed-opal: geometry feature reporting command
      commit: 9e05a2599a37295eb2dc5c03441daa6741abed4b

Best regards,
-- 
Jens Axboe



