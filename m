Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1983D5658
	for <linux-block@vger.kernel.org>; Wed, 13 May 2026 06:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778655336; cv=pass; b=S+VcsnuiyErCl8NJHp0XVmBSxYolopTPfZq/F8oUJen5lGw/0DsI2jQrfnNhnCbdPAIJWyCqaeO8FQ9DExUkbjD+EAsXww/OFUwNCC30Ot/NRXu0z9/o3E2jFNNx22QxEOECTHKiphhS7CTXKXLb1ayavmXkSYlxKooFyAIINWQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778655336; c=relaxed/simple;
	bh=7dt5wcsyMWrioOyjznf39g9Y1em/OOQBDvsh27dmGEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ijJzj4NB0nxqdw75fwKdm62U7XZ54eK65W/HNS43QpCB6T4DOglPUYAJZQJVyRzRy5tC28f3MdtL3QEp6ZjuEnWIFOZAmT/KY7e6ifzIvlqzKXsV0M5LrgxazFJkgzTTyC0iOdJOWhr/az20mqp4jJnOsqxp2Y0daxwL1uzrnAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IQKPf7Fz; arc=pass smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IQKPf7Fz"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13354eb66baso2224615c88.1
        for <linux-block@vger.kernel.org>; Tue, 12 May 2026 23:55:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778655334; cv=none;
        d=google.com; s=arc-20240605;
        b=cBB8kaOkvIol+HYw7dtFBc8+/tnrgKEFVlL5N5JYmnUP/Q80WdezZZu+lVBHgP2LDW
         krHO4J+ph6cOuuEgxdSkG2KGTFfsyALaO6VJgjp7mj3GlyqF2DKp+EC3mo0TToayVRjT
         QNx1sEgeqfs4zoDPLyEbVKg+uRu5H6fXdNcBvKToxh/1JamvKaALtgzZTX3ElM/SvCI8
         YVJ0/O41NU1cj0DzOX3sfLPQgH0uFFZptYT660bcePSAXLKIPU5u/oNDItCWFW6mnMbZ
         phoNdxVrRgFRr3Nzqbzb7d6PR2bnAwWMfYbk3LUNgOSOpMsBHPL4tgPcG7f/j8/edDsZ
         AA4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0fjMIr+AazXFOmcGhY1TbpCVNTCSCuLMXspTkFT56vA=;
        fh=pqjs5njtX2/28PubR4lNRi9hUZBY4AR+P4DJN1DwbrI=;
        b=lyPhRPLev/pbVJVyDCPOWWKQV1T6uituOyJQ126ebNivSCsjWW1nFg3zpMYd5aIwbP
         7wAlq601ghmvh4UE29xmVEgu/5YskKZCMi8phkc3DmoOPei8bQ6xfRcg6zDGchQJh8dA
         dWT3/R0N0SVoAOETeVH0e9rDKqw6I5AaGUpiLKLHI/dVbep8Bg9t5GMecDo8W6rlezU4
         D+AP26B9IPTrKIBHzJFolzgVnbEcXYwPKrOWE9ZlEhaoknS5PS3S1SVlWzbMdb0VizJk
         Y0/io6a+INo6aINd71GQYX/l9QOriFw96tqK5VCf4oKQEq4fPSkCVr2YDUowCCkUMMuY
         p3zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778655334; x=1779260134; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0fjMIr+AazXFOmcGhY1TbpCVNTCSCuLMXspTkFT56vA=;
        b=IQKPf7FzLQkx9EkqZ+ye3Ct+fkK8mT1az7G3tcj5U7RYUYcyMkHrxVOddxE1+V8iAv
         KZ6BScIsQrO0vthVbRJXzUXw02f3VlBbPUAO7ZsRSuO5xqTvIqy3KkUb6Xoip/FcDoq7
         2qzG/gokPjlBctEQpHrspTSLBw8aAd3b3qOMeLQH/qVIm6qGDmAX2XVde6WR0lOamInV
         3HrLzNn1/k5NLV6qtFv+0EGJ8LKwBfF54k+pHz9BykggBfUlA+ldsi4hhDIz1h6SF/dn
         c4S+yeGr5HC+Z9xlGLEwQ/gxirRERB9xXm4BJLPdPemG0nbX4E14+seOU8LCoV5dQJDA
         o42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778655334; x=1779260134;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fjMIr+AazXFOmcGhY1TbpCVNTCSCuLMXspTkFT56vA=;
        b=X+k62X2jMtHQ2dO2lDVerQ+H4TmsHDlY/A1ghGjStey+2PNuJWt0OontyHknneK4By
         XEA1iAYvVE61w5PAowwpE/mxuSVnMy/iBehQywvv9hgz5EinCM+O5gKNaLeapYZ0WBri
         hwhYCSkEDokaUpx9DiSoBLCQEc1+ZD0SZqg8BYfHPL0XUNaT/PKZuZDCX/jJH9ONQNF0
         nomp0jTu5Ghh0lJv33eId2NN9AqkkdUormstXul7dgYo5M4z/sHpzXeWKVEn7cxYo235
         s5GEe2CJdrEDO7aMSkWGsVo7FMsmJ+H/hCmgWXHShl972cWOhb9aO6am6KV0bS3bEK7b
         9Cqg==
X-Forwarded-Encrypted: i=1; AFNElJ+HiRYyGumrOmeWwGiA9wkKANZQjOWkxuaHJGf1AiWhSmTvdc0qn70FntWtMma+2cPL6Lh3b4hGcWKICA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHYh2MENTc8kGIgGo6ZmaF29md8KaKvB1LZls+mH4CjCAMaY1E
	CLnfedpggKUGrSE3atmB8+n1k0ZkhXj7lwiRBYC/swrDfjVwpdC0EeLq27ABNzEK0d7q+KTsW4h
	jBC4mvfVgu4ni18wVG9V7xRab355b8bKYHXy5kBqT
X-Gm-Gg: Acq92OGagxSmyTZaQ6OvYXrBpAv8sh860jUPXW9mmK6LQUpjaI/fpLuAUVsgqxDlXu2
	eppkqHK1IlJhazN6NtjUuIzcMxGUDDhemLnDXzblEIsdTPqIhoyPo0odP7MGf/RCZjn3T9S8oPk
	HBTHGRMnLdnUsph/UyqjmweJAX7917TKgwwCoUIc1qchZlGpymNl9hfW/rujQ1VYxBOzpzFPOqI
	OfhyqVJfDulNUkDWNJb8uAx+thBY7lRZmtOit1rILIy7VAQlSBI9azgSZTUxLmqoTK/4+fAtSAt
	POW0mu+qMH9+7sXT+zVjoSBMguoVk7BYwav2ntJIQGrmh05UCA==
X-Received: by 2002:a05:7022:618a:b0:128:bf8d:44d2 with SMTP id
 a92af1059eb24-1342ee48abemr1322242c88.2.1778655333804; Tue, 12 May 2026
 23:55:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260511163100.1887263-1-bvanassche@acm.org> <20260511163100.1887263-3-bvanassche@acm.org>
 <CANpmjNNMDY=gB23ejdDYZg5yYduup_iXE1FAWC-fghr2od7Hwg@mail.gmail.com> <56a1f905-2348-483b-a79e-5b3ebbd3482d@acm.org>
In-Reply-To: <56a1f905-2348-483b-a79e-5b3ebbd3482d@acm.org>
From: Marco Elver <elver@google.com>
Date: Wed, 13 May 2026 08:54:57 +0200
X-Gm-Features: AVHnY4IvUvDXyE0Q4srNyvsrpvMkG-vOg8i7enk6PE-XAhuVL9MR7PeCfJD_yyo
Message-ID: <CANpmjNM_rCMzbz88SSmmQU2h0+OvjoyN=VapkBc4OEwF=fRcvA@mail.gmail.com>
Subject: Re: [PATCH v4 02/12] block/bdev: Annotate the blk_holder_ops callback functions
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 21:28, Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 5/11/26 3:19 PM, Marco Elver wrote:
> > On Mon, 11 May 2026 at 18:31, Bart Van Assche <bvanassche@acm.org> wrote:
> >>
> >> The four callback functions in blk_holder_ops all release the
> >> bd_holder_lock. Annotate these functions accordingly.
> >>
> >> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> >
> > Because of this change we'll need clang 23, or you add:
> >
> > CONTEXT_ANALYSIS := $(call clang-min-version, 230000)
> >
> > .. although anything else that includes blkdev.h that has
> > CONTEXT_ANALYSIS := y, but is compiled with clang 22 will break.
> >
> > Would have been good to wait for clang 23 to be released (August this
> > year) - although if we consider the next merge window + final release
> > of Linux 7.2, it might get reasonably close to August.
>
> Hi Marco,
>
> How about detecting whether or not Clang supports context annotations
> for function pointers, e.g. as follows?
>
> diff --git a/init/Kconfig b/init/Kconfig
> index 2937c4d308ae..61e592205179 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -32,6 +32,9 @@ config CLANG_VERSION
>         default $(cc-version) if CC_IS_CLANG
>         default 0
>
> +config CC_CONTEXT_ANNOTATIONS_ON_FUNCTION_POINTERS
> +       def_bool $(success, echo 'struct __attribute__((capability("m"))) m {
> }; struct a { void (*fp)(struct m* m)
> __attribute__((release_capability(m))); };' | $(CC) -x c - -c -Wall
> -Wextra -Werror -o /dev/null)
> +
>   config AS_IS_GNU
>         def_bool $(success,test "$(as-name)" = GNU)

That works, but invokes the compiler every time to sync the config,
adding a tiny bit of latency; I think we already have too many of
those, and in this case a version check is sufficient. Clang 23 has
not yet been released, and anyone using the current dev version ought
to use the latest one.

Maybe Nathan can keep me honest about the real overhead of this. :-)

Thanks,
-- Marco
