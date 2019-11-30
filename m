Return-Path: <SRS0=ZuuS=ZW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D01CC432C0
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 18:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39C702075A
	for <linux-block@archiver.kernel.org>; Sat, 30 Nov 2019 18:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqIhJxKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbfK3S4i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 30 Nov 2019 13:56:38 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:43915 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfK3S4i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 30 Nov 2019 13:56:38 -0500
Received: by mail-qv1-f67.google.com with SMTP id p2so2574408qvo.10;
        Sat, 30 Nov 2019 10:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0UHRKhmLt5buFa6gOweNrq+UrUlF6bhjJjwMgeW4uPI=;
        b=PqIhJxKij3aopu/sg/VlF9UH78PhXONkLROSSnUW1HD9S/4eBgKT3PaA1GG0n8vcKI
         +WNkJxTCoUEfdTbcUG1DR0uFrRmbrVboff+KtMRzvA5JBBMx0aiwDlqVfRaZhUwLPxKb
         myK0X3sGnVrWzBpY0DeBBRTXev+2PJ0q+IrRG5PPtB1h68O+C2DpaA1/J2omRptDmIq7
         f317hUxmET+xBwvkjXBpF1jjjyENUbu5876u/c7VwIcygEhydyxk17A/6DKqQ4WhxmHb
         BT7jLRZPfeqJxWf4ZfdD90rs3UA2M2MuCfkg5yqErxymo+yVbFZrBB/0ClH1HpXyyQ5X
         u0cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=0UHRKhmLt5buFa6gOweNrq+UrUlF6bhjJjwMgeW4uPI=;
        b=WZ+vtg0LN2NljXeF75+UyN6LNAqALiX6Jd5he9E+St9H1PjG9BSROu0uPiNSWDJO2t
         BrIyZt3Wos0RWkUEds/esvoqyi13LOhoEHoYBUNBTgNX8IWgkVWD3nw3PnWlrWUBukJc
         XDMBIrx3cFkUy35oPe1w/cLubaKZD5MVF6p5JS3eLRPRdx9tPfqbxmJE/c2TXR9G8955
         819+5Ep8Ecekc9RyA4lHwopOpNMA4pPUBapPfwSTCcm5IwP0kcuQ3iRuBEMBme+wQ42y
         KRHv6c0oy0R76QlVA2RnXboSxjXMrqmVoP93JppVLCcPCrQdnkgKtEmICQiTRF9IZits
         A62w==
X-Gm-Message-State: APjAAAUR2QVMEWqSLCWnpekThn6RHbQTZtRbQnpqPhe2TkE4jGY5i9H8
        d0M9zXQQGMGz0mo6/EAh7uk=
X-Google-Smtp-Source: APXvYqx8qU6RJnI325JY7MaQWh5O3CtZD6+mlYs4h1oB4FLIYP1JYPOoJ3yDaZJq/HN+vIAnUeoDsQ==
X-Received: by 2002:a0c:9304:: with SMTP id d4mr14851306qvd.12.1575140197113;
        Sat, 30 Nov 2019 10:56:37 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 40sm13502875qtc.95.2019.11.30.10.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Nov 2019 10:56:36 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 30 Nov 2019 13:56:35 -0500
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: optimise bvec_iter_advance()
Message-ID: <20191130185634.GA1848835@rani.riverdale.lan>
References: <cover.1574974574.git.asml.silence@gmail.com>
 <06b1b796b8d9bcaa6d5b325668525b7a5663035b.1574974574.git.asml.silence@gmail.com>
 <20191129221709.GA1164864@rani.riverdale.lan>
 <71864178-27d6-c6fb-a66b-395dc46041ac@gmail.com>
 <20191129232445.GA1331087@rani.riverdale.lan>
 <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7be4b7fb-5c14-3c3a-e7f1-c5cc6c047f60@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Nov 30, 2019 at 12:22:27PM +0300, Pavel Begunkov wrote:
> On 30/11/2019 02:24, Arvind Sankar wrote:
> > On Sat, Nov 30, 2019 at 01:47:16AM +0300, Pavel Begunkov wrote:
> >> On 30/11/2019 01:17, Arvind Sankar wrote:
> >>>
> >>> The loop can be simplified a bit further, as done has to be 0 once we go
> >>> beyond the current bio_vec. See below for the simplified version.
> >>>
> >>
> >> Thanks for the suggestion! I thought about it, and decided to not
> >> for several reasons. I prefer to not fine-tune and give compilers
> >> more opportunity to do their job. And it's already fast enough with
> >> modern architectures (MOVcc, complex addressing, etc).
> >>
> >> Also need to consider code clarity and the fact, that this is inline,
> >> so should be brief and register-friendly.
> >>
> > 
> > It should be more register-friendly, as it uses fewer variables, and I
> > think it's easier to see what the loop is doing, i.e. that we advance
> > one bio_vec per iteration: in the existing code, it takes a bit of
> > thinking to see that we won't spend more than one iteration within the
> > same bio_vec.
> 
> Yeah, may be. It's more the matter of preference then. I don't think
> it's simpler, and performance is entirely depends on a compiler and 
> input. But, that's rather subjective and IMHO not worth of time.
> 
> Anyway, thanks for thinking this through!
> 

You don't find listing 1 simpler than listing 2? It does save one
register, as it doesn't have to keep track of done independently from
bytes. This is always going to be the case unless the compiler can
eliminate done by transforming Listing 2 into Listing 1. Unfortunately,
even if it gets much smarter, it's unlikely to be able to do that,
because they're equivalent only if there is no overflow, so it would
need to know that bytes + iter->bi_bvec_done cannot overflow, and that
iter->bi_bvec_done must be smaller than cur->bv_len initially.

Listing 1:

	bytes += iter->bi_bvec_done;
	while (bytes) {
		const struct bio_vec *cur = bv + idx;

		if (bytes < cur->bv_len)
			break;
		bytes -= cur->bv_len;
		idx++;
	}

	iter->bi_idx = idx;
	iter->bi_bvec_done = bytes;

Listing 2:

	while (bytes) {
		const struct bio_vec *cur = bv + idx;
		unsigned int len = min(bytes, cur->bv_len - done);

		bytes -= len;
		done += len;
		if (done == cur->bv_len) {
			idx++;
			done = 0;
		}
	}

	iter->bi_idx = idx;
	iter->bi_bvec_done = done;
