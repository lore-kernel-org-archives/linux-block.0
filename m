Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF24413D8C
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783682031; cv=none; b=FfMI+maiiuIRbjRnPNlGtM2/RYrc696BZ5AC1hOmuqBZZ4HwiWQcZpTBl3iTq+lZn2ugmXM+hMPt/2Qt6jElC57Kps2vLCePUXCSg3mDkzYLTq7nerMI6IwsdhrIy3mvsV+oQrbMuHO4ei2MTV9G+tkqHd/zw68QhkPWEll5rDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783682031; c=relaxed/simple;
	bh=c4OVHU38z7vfkatYPQKtn8vnc7akYZidlGLsN81aP0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+vXQDKO7HH5L+DUcD4XMNnwjiMqi402Fk2mTQdUZNfhzdJAGJhGgiz4HIlz7XkW7X20n11/+AVhNGIrIvofB4JfpzP0QkqOxQYOUAJR8hBfaL79rlGKBazodaCocTCyGl499cpHkKzjYNFcmk+r8DFlz8js0H00v5LhaXRMcWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b=Gu3tOBcG; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20251104.gappssmtp.com header.i=@linbit-com.20251104.gappssmtp.com header.b="Gu3tOBcG"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47640541585so413130f8f.1
        for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 04:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20251104.gappssmtp.com; s=20251104; t=1783682027; x=1784286827; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ODgufXz1PhelMlB2W5pp8vf7ivTLwxqDccyqSe9smQ8=;
        b=Gu3tOBcGf3T0pnU9ybwJ1OIj0sxHVMkkaVxMCpYU1p+VQfXrRcf8t/tZq4Nl9iRgrb
         jedOKWmhfFdqNIBXQuF27OcoYXMobk5QXFhM/CeFArNDEzILbQscmFisasjsQsFVFmT6
         n70WRs3rocq8pj9uCxgEYoqUVecNlXWK5WWyrBfZ7lkjY4imeN5GobWtbADjQSazOER3
         zUJs1w1n/cUWM+k/n9t7cAxyAF708wvv8Xnfq89Gg4VZfqLCP1u+Rx3xLeuUA/C7xYCm
         zzb/QmgHnpBVTyUyOFFkaIipLq1JCIf3sFKPvgz9iaSMXmUSp5WOzTOHyJOLhFw5Fixc
         BOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783682027; x=1784286827;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ODgufXz1PhelMlB2W5pp8vf7ivTLwxqDccyqSe9smQ8=;
        b=YUWAT0QSmJuVtntqrRGZ0fZeVRSdISh23R0LOmEb/5JKNRCRwHTrEhcygvDf8cKfKX
         UPaNV1bxpOcPRzT8p+jT8rvJ1seDdWaPHBJ78dJj0dl5NF8X4DlnXtL2cjZWTXilAO5q
         DY81ZPwK1dU/CzNM5/5ExDVvUCYPxDKK324EP0ahpw+ZtTlyuqAWHc8108/i7I1aEYUA
         WncDp8C+HbqWly05NqEq0eJid3SMn/HqWGVC7ac3OB+8D506BHdLrHgBTfyIWtKaH9y0
         1qf6EtVFQtcUyEpZwcqR3fCNHJXSKl/dg8IArTK5uzgbFvOUIc8b8czoSROGqV4rz+tM
         VlCA==
X-Forwarded-Encrypted: i=1; AHgh+RoLdqF7r3FhoZ8dDGspWz8QdD23KNk0C3EsdwE6uwaq3Ex1L9v0eaPF5binnbyJgtyO4zw59QmrkhBdDQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4eWpqjMRh5p4WB9zG019L2Ny14cVMHbV0NRDdfTH6paZHpwAR
	0irgeLUTJMZ3/gvUWGSJNA4cr/0xK7jWHbxTEJIZhJ3FXmonJVoeMHnaBAGuKACnF30=
X-Gm-Gg: AfdE7cmAKJOT4tQHu8QDpU9bDLAiiPKdEqIXDoAaD6StK6xVaBCVZiw6MiBm2eQQ7ij
	SGKFG46DgWBNLE0OLSRC3GO35TMJf7jYEnkmnYRESi4SUbGBllMgqa1RcSpf8BFbAzCPNsiViIN
	Uoqr3I3JKRAwpyKfQZcw69V55yKv1AtUWFwZh4X+AU3bag83P69G39Of3XEZ8+Ot86QhXGsaz2n
	kG2ZBC2RKCr0caSdyLsLeo1iiXtx5koUl+yR6yHipCTsnUsFLL86EMhqG9uV91OZlwWFtOLeMyP
	9XTHHATl1D5uvkeVmUPAx5LW6uK28oWi+5nm1SsP01MI2bpPOXOkXIXj0USgcZhKpLGo0i9nVCS
	3mlhw5njb3g4jgZHCgMR63fuZOfwnn+EfW+8W682gfYkMZeglx6BJTmHwhDtfSUWCtFwsOPqXJb
	NpguolCrFspYtaVSpJ0hyVV9qTYsdy5mOU2MlCtDeE0H/Turi0dDOl4lcQ
X-Received: by 2002:a05:6000:2482:b0:477:6874:5415 with SMTP id ffacd0b85a97d-47df074605amr11973058f8f.26.1783682027154;
        Fri, 10 Jul 2026 04:13:47 -0700 (PDT)
Received: from localhost (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47a9e4d6e4csm56399132f8f.10.2026.07.10.04.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 04:13:46 -0700 (PDT)
Date: Fri, 10 Jul 2026 13:13:45 +0200
From: Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?= <a.vatoropin@crpt.ru>
Cc: Philipp Reisner <philipp.reisner@linbit.com>, 
	Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>, 
	Andreas Gruenbacher <agruen@linbit.com>, "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] drbd: Fix potential NULL pointer dereference in
 _drbd_set_state()
Message-ID: <alDRuDisKeheSGc8@linbit.com>
Mail-Followup-To: =?utf-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?= <a.vatoropin@crpt.ru>, 
	Philipp Reisner <philipp.reisner@linbit.com>, Lars Ellenberg <lars.ellenberg@linbit.com>, 
	Jens Axboe <axboe@kernel.dk>, Andreas Gruenbacher <agruen@linbit.com>, 
	"drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260625050016.12004-1-a.vatoropin@crpt.ru>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625050016.12004-1-a.vatoropin@crpt.ru>

Thanks for your patch.

On Thu, Jun 25, 2026 at 05:03:06AM +0000, Ваторопин Андрей wrote:
>From: Andrey Vatoropin <a.vatoropin@crpt.ru>
>
>The connection pointer receives a value in the _drbd_set_state()
>function, including through a call to the first_peer_device() function.
>This function returns a pointer to a list element. If the list is empty, it
>returns a NULL pointer, which is later assigned to the connection
>pointer. Subsequently, this pointer will be dereferenced.

Can the list actually be empty at this point?
The peer_device is linked into the list in drbd_create_device(), before
add_disk() and before the device is inserted into connection->peer_devices,
so no state change can reach the device earlier.

It is only unlinked again in drbd_destroy_device(), after the last kref
to the device is gone.
The connection itself is created together with the resource in
drbd_adm_new_resource() and lives until the resource is destroyed.

So for any device this function can be called on, first_peer_device()
returns a valid peer_device.

>
>Add a NULL check for the connection pointer to avoid dereferencing an
>invalid pointer.
>
>Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
>Fixes: a6b32bc3cebd ("drbd: Introduce "peer_device" object between "device" and "connection"")
>Cc: stable@vger.kernel.org
>Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
>---
> drivers/block/drbd/drbd_state.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/drivers/block/drbd/drbd_state.c b/drivers/block/drbd/drbd_state.c
>index adcba7f1d8ea..ea982d48017e 100644
>--- a/drivers/block/drbd/drbd_state.c
>+++ b/drivers/block/drbd/drbd_state.c
>@@ -1281,6 +1281,11 @@ _drbd_set_state(struct drbd_device *device, union drbd_state ns,
> 	if (rv < SS_SUCCESS)
> 		return rv;
>
>+	if (!connection) {
>+		drbd_err(device, "No connection to peer, aborting!\n");
>+		return SS_ALREADY_STANDALONE;
>+	}
>+

Also, even if the condition could happen, its handling here would be 
wrong. Since this check happens before handling hard state changes, 
those could potentially be skipped, which is not allowed.
For example, after a local I/O error (drbd_chk_io_error), if this 
condition would trigger, the detach state change would be silently 
skipped. So in that circumstance, this patch would be actively harmful.

Also, SS_ALREADY_STANDALONE would map to the error message "Can not
disconnect a StandAlone device", which does not make any sense in this 
context.

> 	if (!(flags & CS_HARD)) {
> 		/*  pre-state-change checks ; only look at ns  */
> 		/* See drbd_state_sw_errors in drbd_strings.c */
>-- 
>2.43.0

In summary, unless I missed something major: NAK.

Thanks,
Christoph
