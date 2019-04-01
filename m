Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA13FC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 09:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3E52086C
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 09:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=demfloro.ru header.i=@demfloro.ru header.b="gb0xgaf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725859AbfDAJWl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Apr 2019 05:22:41 -0400
Received: from mx.demfloro.ru ([185.52.0.75]:44608 "EHLO mx.demfloro.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbfDAJWl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 1 Apr 2019 05:22:41 -0400
Received: from fire.localdomain (unknown [IPv6:2001:470:28:88::100])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: demfloro)
        by mx.demfloro.ru (Postfix) with ESMTPSA id 44Xn1W2F82zB2Wl;
        Mon,  1 Apr 2019 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru; s=032019;
        t=1554110559; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WE7kj35/YNbuaF1z8TcnoxKlXZqAEXoG6Ng23i75B4=;
        b=gb0xgaf2cuBsEVQQMLsngBw6Eq1ZZD1r70ebiTWBHxvGKbYqK8/EbA5wachfStDmHMoPxX
        tKefyPyRMp0viPNijOYC4xzBpUaXAey0qz1Z/NnMO61tAe7luU9l+3DapgvdDlp/BTf09b
        44Uw9YwM78s2z8/LQBYE5OzwVegh7QOF2CQPNyR4CsyC3IUh5834PfkF6AY2mCY7iaDMNU
        P+xk2iK5nPm7BVhc03MpxPhNOw3+auwhPfIMamlxK8t+bOuaICTGyPtqZ6A7Mwu941E6NP
        d48PHPlfhkhzmWDjRfNacNoFRM1x+y5R59K0tEkosbENFyeHhiFZDEKomG67Bg==
Date:   Mon, 1 Apr 2019 12:22:33 +0300
From:   Dmitrii Tcvetkov <demfloro@demfloro.ru>
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Bisected GFP in bfq_bfqq_expire on v5.1-rc1
Message-ID: <20190401122233.3e861312@fire.localdomain>
In-Reply-To: <84B0CA50-0ED8-4171-8007-19EA43951735@linaro.org>
References: <20190329160227.7d55c8dd@fire.localdomain>
        <0e203a26-b941-cef4-dff1-013999d4b041@kernel.dk>
        <626EAE58-63C1-4ABA-9040-9D9A61F74A0D@linaro.org>
        <20190401115509.76310e03@fire.localdomain>
        <84B0CA50-0ED8-4171-8007-19EA43951735@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=demfloro.ru;
        s=arc032019; t=1554110559;
        h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WE7kj35/YNbuaF1z8TcnoxKlXZqAEXoG6Ng23i75B4=;
        b=cHGP5pr62tDBcGVLWdCF+4qKmAqtcdouVLGjRq9+TM2gPThgJU59yiWy6oVMFI968kJ8Tg
        e6TpiviBttFYyLEuytOhXj1RaOt5i8LyaFwRbwW7KMLQ8Q26S2rmrEMHuURDTOeTHtV14y
        DnMuVtVL03zEWWvhJBJUoj66bWRlPlb80c44hx3AEdHK4im7zw8kZteulePJmx7pvCjzfB
        yF4aVqUHtIqk1YZYxzJsbQw8SAe2E35dCtg4wROmHmdSJABgA4wHX4RsBtvsEMcBGLW9xP
        Mw2ngEQupksUu2SUGFbbx7EgB7ZApw1sNkwtMA7PUfJuxuRa5Eik1xB7Gag8vA==
ARC-Seal: i=1; s=arc032019; d=demfloro.ru; t=1554110559; a=rsa-sha256;
        cv=none;
        b=VPsQSBYeoYADkptGwqQ6/ORU9Az//7aG3xbJEvS7aOoVwjTZbFrj0//Ibb5TQco4BPsJbw
        aLQHAbitcWXsOvb8vcPwR0c0pL6wifosQC3pK1fgjajRiIy4/1EqUcJbY/COE+G61kABgN
        u1HQHfwt1C8ySpHpdTjHmnoz2vXHZyjiEjt0qFUgsfs8PcTXy18HMKOjlOe6vQ6+5kPG/K
        6YG+Ubj7N3ZZILa3EoOI5KdxhD/E6cMUvShYb6/mEDhQeVC9ECI5OWesEK5tDSu1lCK+al
        bDZC+E7Rg6x/uC6Rod646BOU6C50+96x4qBpdMSrNXlGjReECDml34ZBL4KZEA==
ARC-Authentication-Results: i=1;
        mx.demfloro.ru;
        auth=pass smtp.auth=demfloro smtp.mailfrom=demfloro@demfloro.ru
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 1 Apr 2019 11:01:27 +0200
Paolo Valente <paolo.valente@linaro.org> wrote:
> Ok, thank you. Could you please do a
> 
> list *(bfq_bfqq_expire+0x1f3)
> 
> for me?
> 
> Thanks,
> Paolo
> 
> > 
> > <gpf.txt><gpf-w-bfq-group-iosched.txt><config.txt>

Reading symbols from vmlinux...done.
(gdb) list *(bfq_bfqq_expire+0x1f3)
0xffffffff813d02c3 is in bfq_bfqq_expire (block/bfq-iosched.c:3390).
3385             * even in case bfqq and thus parent entities go on receiving 
3386             * service with the same budget.
3387             */
3388            entity = entity->parent;
3389            for_each_entity(entity)
3390                    entity->service = 0;
3391    }
3392
3393    /*
3394     * Budget timeout is not implemented through a dedicated timer, but
