Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73253C282DA
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD192086C
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 17:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfBARAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:00:11 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]:36204 "EHLO
        mail-qk1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfBARAL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 12:00:11 -0500
Received: by mail-qk1-f181.google.com with SMTP id o125so4477726qkf.3;
        Fri, 01 Feb 2019 09:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QbdUtNqyzY8aWiO+TUUzxUNovBOkGpn77yjCRY7A6lc=;
        b=Bonjio//n2Cf881ObiesRrTieiPcl9o0cPUUk/F+CE7fJzmdEItL/2OZJxauKjGzF7
         uudK8B/cBax+d8s4RLnVHy8/WImsACP4tbrx2nc8pP2X+UjnMxj6Mk3KxRDtEKr9np62
         6E+O7raDpxRWoJVAnmnfESbMRnnPbXcI8dr0kKu8VHClrvmN4fpeJK8i2tNy4veyX55l
         7sB+emvKG9ieyW8gXcdApLrfJXS268rodF2sUDstUKiVeNvhLHdyMR4OF73A88DLKCU9
         OrKJ6HeynJygP2t11yNDFjoryAxdzX7mX+wpYZ/n35hNumzEsHI6/7unWsJMNVRyZbox
         RfTQ==
X-Gm-Message-State: AJcUukcPUOAls9wKt1Pph5s8bERbbcTP6CVX+wi41gF5pk/9ZhZGLebV
        kX5X1RWAQWue9V5rk/JLMx0=
X-Google-Smtp-Source: ALg8bN7x1z0Fq9SM5wZJLYssoLiQtucPRyt14pXwfHm6RfqSEq3/4Tkug97vn9r3VLdq5xydN6nMNw==
X-Received: by 2002:a37:b2c2:: with SMTP id b185mr35866637qkf.194.1549040410185;
        Fri, 01 Feb 2019 09:00:10 -0800 (PST)
Received: from [10.204.111.90] ([184.169.45.4])
        by smtp.gmail.com with ESMTPSA id 189sm7435549qkh.9.2019.02.01.09.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:00:09 -0800 (PST)
Message-ID: <1549040392.164323.2.camel@acm.org>
Subject: Re: [PATCH 04/18] iomap: wire up the iopoll method
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com
Date:   Fri, 01 Feb 2019 08:59:52 -0800
In-Reply-To: <20190201152414.23296-5-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
         <20190201152414.23296-5-axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-7"
X-Mailer: Evolution 3.26.2-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 2019-02-01 at 08:24 -0700, Jens Axboe wrote:
+AD4 +-int iomap+AF8-dio+AF8-iopoll(struct kiocb +ACo-kiocb, bool spin)
+AD4 +-+AHs
+AD4 +-	struct request+AF8-queue +ACo-q +AD0 READ+AF8-ONCE(kiocb-+AD4-private)+ADs
+AD4 +-
+AD4 +-	if (+ACE-q)
+AD4 +-		return 0+ADs
+AD4 +-	return blk+AF8-poll(q, READ+AF8-ONCE(kiocb-+AD4-ki+AF8-cookie), spin)+ADs
+AD4 +-+AH0
+AD4 +-EXPORT+AF8-SYMBOL+AF8-GPL(iomap+AF8-dio+AF8-iopoll)+ADs

How does this interact with block device removal? My understanding is that this
function can get called after a request has completed. Which mechanism, if any,
prevents that request queue 'q' is removed after kiocb-+AD4-private has been read
and before blk+AF8-poll() is called?

Thanks,

Bart.
