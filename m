Return-Path: <SRS0=Gq2m=W6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ADD9C3A5A2
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 16:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1201623431
	for <linux-block@archiver.kernel.org>; Tue,  3 Sep 2019 16:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EKHkp/aq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbfICQXK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Sep 2019 12:23:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34726 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729692AbfICQXK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Sep 2019 12:23:10 -0400
Received: by mail-wr1-f68.google.com with SMTP id s18so18212960wrn.1;
        Tue, 03 Sep 2019 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TepBcnay70WrGmb0WBkOD/Cs9CShXo+TxS9/OGqh6Bw=;
        b=EKHkp/aqR3DigOCLFd9MIjlOwoKCQetnK8fr3HngH/gmy44B/y+LUfRJnQJYWb6Cvo
         8mEv5H9vPsNOdeBU6+QazVE8YKbL4Ks0DybjlhHXBqNmcH8loNv9Yp47V1EmvhvpineH
         M0H4k3nAyfQh480J1dBLjqfa+BSK1wWphJaM2ef0qpf7OjVmdoHnF9SQt+HNNmNQ2at/
         Y9yU3fbQC4I2CC9fwIX1huaI5p9BHj9JMlCN+EKbXwcPw3B/YI8zycMEkVzAScoOuEf1
         juB1OBjcPWcL3N+j+VnKYHpHRr34IiVZ//Oo17/9CkRglejFCo2L6hRYuW4uNwWs2/er
         nO3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TepBcnay70WrGmb0WBkOD/Cs9CShXo+TxS9/OGqh6Bw=;
        b=mDVJcfuwdqr9YWNQo95DSAOJ4+Ex/BhxIblcdPsGpZaiTdLiwxTzz2CytqX3uKFAR2
         Nb+1cFSLdQ6ke/4weyXcKVOv6ZmYxaLt9a1+19BqiqyqpBD3IeMz/H5J4AFDrrQB2V8L
         ZRIChqxmwneojC0p2XJ8YjvSYZbYndzMdZVXTWx5jy8DrNh39/siTdbjcMJqQdSRdLWP
         mmv8K0h1+NwBB6bh0okcO1wsgzjRaIJO8r4zSokJfV9XtrngHbduyLnnC8AgRA3fL/7B
         yPrQtP+0zGI40kYAqfIRLG0tgiGJH5KSI/k3y2BEc3Ppe9c3UqAyGd5DVXZCB3mIandd
         w3jA==
X-Gm-Message-State: APjAAAVLWd0HzAOeDMGD4VPlBZ+XbQv39sRli68MmFYHiXbRJTmOcI+w
        quzTu1s7bYyn7+7Vbs3bMw==
X-Google-Smtp-Source: APXvYqwx0bJ6xnL9cz14xzE50FT6ThicgK4OWReQhuR8YKvDLg+VcrlLQG0HKsV1CSwULWCwxVvs1A==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr8540655wro.17.1567527788037;
        Tue, 03 Sep 2019 09:23:08 -0700 (PDT)
Received: from avx2 ([46.53.254.228])
        by smtp.gmail.com with ESMTPSA id c74sm11892wme.46.2019.09.03.09.23.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Sep 2019 09:23:07 -0700 (PDT)
Date:   Tue, 3 Sep 2019 19:23:03 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        aarcange@redhat.com
Subject: Re: [PATCH] sched: make struct task_struct::state 32-bit
Message-ID: <20190903162303.GA2173@avx2>
References: <20190902210558.GA23013@avx2>
 <7b94004e-4a65-462b-cd6b-5cbd23d607bf@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7b94004e-4a65-462b-cd6b-5cbd23d607bf@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Sep 03, 2019 at 12:02:38AM +0100, Valentin Schneider wrote:
> struct task_struct {
> 	struct thread_info         thread_info;          /*     0    24 */
> 	volatile int               state;                /*    24     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	void *                     stack;                /*    32     8 */
> 
> Though seeing as this is also the boundary of the randomized layout we can't
> really do much better without changing the boundary itself. So much for
> cacheline use :/

Cacheline use of task_struct is pretty hopeless because of all the ifdefs.
