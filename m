Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59603C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 13:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19EA4239EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 13:59:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbhAVN7I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 08:59:08 -0500
Received: from mout.gmx.net ([212.227.17.22]:36379 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbhAVN7B (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 08:59:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1611323782;
        bh=0JKZZVgCuhRz/+dZq0rU9uHPhlASFQ8/OAly6xYE6dc=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Rl4VD9p31kK3wC8V0+6oMjKlAZ5pPMjmPc3pg8lFPUkjBQkKU9cMnUqkSOTpNB/qg
         ++2EOswptk1Cc7W1NGySCZSv6AVleTBr9nbL0M1XQKQGCwZqFydV60lDzRLuh6yqzv
         YDx6AfXJoS1VaZwpnRdjpaCSHdZ/SxsE9tYRmkoo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Valinor ([82.203.161.65]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M3DNt-1l27RY4B49-003gZG; Fri, 22
 Jan 2021 14:56:22 +0100
Date:   Fri, 22 Jan 2021 15:58:01 +0200
From:   Lauri Kasanen <cand@gmx.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        axboe@kernel.dk, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v9] block: Add n64 cart driver
Message-Id: <20210122155801.a24c328b7aefdcffb7d68576@gmx.com>
In-Reply-To: <20210122111727.GA161970@infradead.org>
References: <20210122110043.f36cd22df1233754753518c1@gmx.com>
        <20210122111727.GA161970@infradead.org>
X-Mailer: Sylpheed 3.5.0 (GTK+ 2.18.6; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:7wQaoruYUbvPdkxn5JMQAbYZnNhc03+MrlvRzQ34I+QTy//gX9Z
 a785xQ56grOEOAqjoIHfZYntXYN/UDrhzqn0jcPyF6rIlQrM5UnZRtej3Che4E3wYX5FhpQ
 95jDif4IJGoqi0N0oX4lW9EY2QtktoaITDeTtKKfZRjjxpcrgQ33Rw8fSfcejgtk2g4PjIi
 kxn6RqjwYnW5pvebslvXw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ciSgC7jfFP8=:Xw9iGkhaO18G6e4QrkhVp1
 l1ymSwsfugNNKHkdbNAHaY1AOPV31zv/RkoeVJJvSVPj9lfq3jD3/uryr5ILuhdqP8hOVGB/V
 sqvq1JIKhZbYnKgExJg4HF8jJscZv+nWl0u0AaGaUv9iG8Kps9M/+59eI2sAIMTAqJmo/IYp9
 GxZU7JpYkUNzhCbqc007GeCyC8DQ/3XK9RBjxVkyph2jYvIXFo2oH3OuXUFeNVfBWpGETkkz7
 N7nso6DlzSgDz7Olx9KrNv8y/uc8dzqgbZpyEjmBnTIaictyT2CJ50wdT+w3djRAnpVBc8I6w
 yeiFSDqkIo3iiaVIGRHlVS4Ps0WrNjPzG81KXW8KrNAL0T2vDWiNs/IYdpLN3fHbPyXJXnHlM
 ZP6WHtqckPE9mVtQyL077jiZSJl8eb5zM+jGRA6ErZB0RG2eaTHlag02ZASI4q1ogBG1n8KNq
 N5VEetcxvoWml4VERH5uf/H9zhm+ZCEWOQHJdi716eQGzf4oxGWKOXFys9DzYdrUUKemKB1iU
 x0YEasmLq13h22GnbbswCOyy4qufSs3zrokrDnNIcclJKpjzlCZloelt973+N7QtiuuayW3Kg
 PYKclrHlLo1mMNtdW3gHL37mcdf5wJFjVOs/hprySOqGG/Kg74i6kcVAz9ZPUTdcY+aI3DtQx
 MEaoRp73EuzyIvzEq5cJ7cpo5lXAw9zCF+7X3hrYZ/sCM/ic/sSAsspcDJWqkdAoSuaS6Ldww
 UuWIYVc2bLcOZmxIvoQS5cCz3gyY3+XZp0LoC7/l2APZC6ll0mMcrYDAX1TDLijAwpQQ0aq+h
 aexnIlu6QWjRILj3yHcGNVbt40KUaNqBD8CiHuH3Vqjw6ux9FMdDuGZaN/LlS0UbAvfO5w/bp
 8HrF4MYKdUj1G4iiHUXQ==
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 22 Jan 2021 11:17:27 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> Sorry for not noticing this earlier, but why do you need the bounce
> buffer vs just mapping the data buffer?

I think I've answered this once already a few iterations before. DMA
alignment restrictions, not sure what guarantees the bio buffer has.

- Lauri
