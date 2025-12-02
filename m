Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88EFF313E30
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764676451; cv=none; b=sqkqcuTbo72qxymu0Xbm9JhlKxCPFzah5TJ+HFUohYGGi+IFPyzXyVEtJIu17YgJx9wo5Z3swjNmu+tDdoOArR17LDwoNMtbQ9iwJ2HqZFJgCpl+AeJu2jeecvN4vp8oOjnDsxUTikbI6yWFohVNlxyL1YZTArPAgsA3eepJfeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764676451; c=relaxed/simple;
	bh=f604AMXJ8Naj25VU08DctYWWhunFC1FlIAv9VKdF5SM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S5aYMS10Fi0QTVICpXXAif2bxnPNnw10shUlugiokR2/Ee66068uhQK0+Who1HpfTbpqA77tyMb6eoWLrdnjlMvMP+i+IxDwxG5uchy8ocUbzouAdf4q9ARHhE/XI1fscSf61/X0CDg6PTCBBL4TD02zfxr1ceskzbiDjq8sjDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVsQuEX3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVsQuEX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F122AC116D0
	for <linux-block@vger.kernel.org>; Tue,  2 Dec 2025 11:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764676451;
	bh=f604AMXJ8Naj25VU08DctYWWhunFC1FlIAv9VKdF5SM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=oVsQuEX3tYS3iTk1ff2ZyRPdOm+KY8482kFByB87yKwChGa3zyjgcPswDouQk0sAO
	 u/bNPFgbw/VuORsYoAi7broWRPtWB/OoyernBbW/pIgZbUdmAqtR1LOX+WnkGWS9cx
	 9f2OShgpAt/w93vymh8dbNstRCdUAZVaSV5vtZQ2+p5J2z2hacz69jYtMRMrm+smzR
	 cSTe1lWAXip4DPxUCJ3OK6YSSAnUF83YXPC0EBAUeC4RFR8fkSWJoGvXD75U022NFS
	 3OkvpArE5jJiEZjiS+jQZ3Pg9D6+6RV3438ikVw62Njbbl9avqs0Xnhr1e3AO77iwX
	 6CPNn1AcRgEBA==
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7c75dd36b1bso3459170a34.2
        for <linux-block@vger.kernel.org>; Tue, 02 Dec 2025 03:54:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvRqO1VDPXWVluzH9goS30koZZKKYDp/mw/oUETCYkdRYzRoIbbU81Bw9vcJDrUsK2tL9GDgLQomA4CQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4gkkBZM5iuDjkVp8rPGij4e7KmRnGUNxav7veZb9mjbnF1evt
	5Ak0OObk4HjWfai3XDnSnY8yatZS0Pe4m8MWiPFjtS+Ryyt4aRK0QwOJJVQ8mV+nZNiEGds4Z1o
	Iv5hbrr7lgCstc2XoWImSagp61YHk2pU=
X-Google-Smtp-Source: AGHT+IFkVQ5NafdmHY3yONdDYzVGIPmIcObIxvnz+SiH8b0PWwO7P5SXmydvFrWtbdILchYd8fGZPUW7CW6ppO0AHE4=
X-Received: by 2002:a05:6830:7199:b0:7c7:68d8:f702 with SMTP id
 46e09a7af769-7c7c410c455mr15317350a34.9.1764676450256; Tue, 02 Dec 2025
 03:54:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251126101636.205505-1-yang.yang@vivo.com> <82bcdf73-54c5-4220-86c0-540a5cb59bb7@vivo.com>
 <CAJZ5v0hm=jfSyBXF0qMYnpATJf56JTxQ-+4JBy3YMjS0cMUMHg@mail.gmail.com>
 <6216669.lOV4Wx5bFT@rafael.j.wysocki> <a461add5-95a0-4750-8d66-850cce2fe9fb@acm.org>
In-Reply-To: <a461add5-95a0-4750-8d66-850cce2fe9fb@acm.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Dec 2025 12:53:58 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0g6ELEFDeTXaWxLAH7wO1eZ+to8xcXd9Nnv8dZYmhg7GQ@mail.gmail.com>
X-Gm-Features: AWmQ_bk1XxDGqeh6Q-AZcLDWvNlGkZ2NsTSirozhZiL0PaXT0_Y3cGigK54YO-M
Message-ID: <CAJZ5v0g6ELEFDeTXaWxLAH7wO1eZ+to8xcXd9Nnv8dZYmhg7GQ@mail.gmail.com>
Subject: Re: [PATCH v1] PM: sleep: Do not flag runtime PM workqueue as freezable
To: Bart Van Assche <bvanassche@acm.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, YangYang <yang.yang@vivo.com>, Jens Axboe <axboe@kernel.dk>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 2, 2025 at 2:06=E2=80=AFAM Bart Van Assche <bvanassche@acm.org>=
 wrote:
>
> On 12/1/25 11:58 AM, Rafael J. Wysocki wrote:
> > So I've been testing the patch below for a few days and it will elimina=
te
> > the latter, but even after this patch runtime PM will be disabled in
> > device_suspend_late() and if the problem you are facing is still there
> > after this patch, it will need to dealt with at the driver level.
> >
> > Generally speaking, driver involvement is needed to make runtime PM and
> > system suspend/resume work together in the majority of cases.
>
> Thank you for having developed and shared this patch. Is the following
> quote from the Linux kernel documentation still correct with this patch
> applied or should an update for Documentation/power/runtime_pm.rst
> perhaps be included in this patch?
>
>   "The power management workqueue pm_wq in which bus types and device
> drivers can
>    put their PM-related work items.  It is strongly recommended that
> pm_wq be
>    used for queuing all work items related to runtime PM, because this
> allows
>    them to be synchronized with system-wide power transitions (suspend
> to RAM,
>    hibernation and resume from system sleep states).  pm_wq is declared i=
n
>    include/linux/pm_runtime.h and defined in kernel/power/main.c."

It doesn't say what the synchronization mechanism is in particular and
some synchronization is still provided after this patch, via the
pm_runtime_barrier() in device_suspend(), for example.
