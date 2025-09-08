Received: from mail-24421.protonmail.ch (mail-24421.protonmail.ch [109.224.244.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950BA2F7AB4
	for <linux-block@vger.kernel.org>; Mon,  8 Sep 2025 11:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757332392; cv=none; b=X+BTVCh2iiyrhw2dMnqfhiNNXAw7m4XpMIaJGGCqnbXBpj1QhdEd7YU26MEQ4vYgs0v2nfsYRcd1PsXj6ckrIHfhf9CJo0nR30xvHS/3JIW8/StaMwi2WWDVCBElT7NTpMwVkUo1JMCzc//CCIeVoLzsgq3bIo/NhnzvIjcFi94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757332392; c=relaxed/simple;
	bh=jx2zaT4wV9oFqYVMYQlAfzlJ4Ndikyb0ap+suyD64XY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OVSqdBPk4FlInJ4OLGJQ7osjEUyRrig9vTzkqKnGOwXB0WzW8YzoaRkrohrAo1XxX4Y0th7fMxsIQTfUsMB5DPgKGmCUL9d2y9zKt7s/zSOJ9ziacUz09Pq7cMkE9KZEVIHpVjzWt8dV+PQbrblGBdv7S0fnXSip0X/Xjacve40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.geov.name; spf=pass smtp.mailfrom=mail.geov.name; dkim=pass (2048-bit key) header.d=mail.geov.name header.i=@mail.geov.name header.b=pFrj15BK; arc=none smtp.client-ip=109.224.244.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mail.geov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.geov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.geov.name header.i=@mail.geov.name header.b="pFrj15BK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mail.geov.name;
	s=protonmail; t=1757332385; x=1757591585;
	bh=jx2zaT4wV9oFqYVMYQlAfzlJ4Ndikyb0ap+suyD64XY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=pFrj15BKl3IdpOOPVKiUmJis2C+TATPD3eIlt7QcCOH9uTKYgc1MAyi7HYxjWUSx6
	 kCCTbSen7/v6ovhvp6Y2zoAoKXUHHrZLvgp7GrQvINhxSduGgWCMuf3HUI/8ajL6Gu
	 VFUjjZXrENxBxFhvz8xZIDIH9at3UsJ3Bt2EFGssLrxfmXBKTDMwgzOqmLpBi3ce8A
	 cgRxA4GtAcXbxj8IA1kWfu+MTXqInH356A1hy38qxC1pDKi3zgCYKeVHJX7jVb6TbK
	 TAeTbaJCK1Zr+KPer5yNhQvNH7gqZ5GT1CN2rEobMmIaJGkSfnNQuVoUZQ+xaEYWcS
	 U5wn8pzMsMB0A==
Date: Mon, 08 Sep 2025 11:53:00 +0000
To: Ming Lei <ming.lei@redhat.com>
From: Heorhi Valakhanovich <code@mail.geov.name>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [blk-mq] Kernel OOPS after usb drive surprise remove (bisected)
Message-ID: <exBcRMEROg6miSMCdAJBfH3QsSlCgmAMkEgqyqK0S2Jjw6M8xQHfV2ejRumuPxFjnLOOT5z-tEoH9RUx3uEwt5T7gAtbTD-mBKccdZ_0xwo=@mail.geov.name>
In-Reply-To: <aL4jQG-_CeHxGPsU@fedora>
References: <LmKwxMZhQ0h6bHWk_m7EMu4jDpbdcL0Z4gix3USIvS2sJpGZP1b_858GvxaDL6zwoGxrPIs-dT10NLxersJpxExsOOpJmyDh_fTOp97ZBYE=@mail.geov.name> <aL4jQG-_CeHxGPsU@fedora>
Feedback-ID: 35076807:user:proton
X-Pm-Message-ID: 837f6f8030ca752eed3e8b7c23eb4fe1701602be
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Monday, September 8th, 2025 at 3:29, Ming Lei <ming.lei@redhat.com> wrot=
e:

> Please try the following fix:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/com=
mit/?h=3Dfor-6.18/block&id=3Dba28afbd9eff2a6370f23ef4e6a036ab0cfda409

Thanks, it works (no crash) both ways: on top of original commmit and on to=
p of v6.16.5


> No, that is not true, because scsi/usb does not call into
> blk_mq_update_nr_hw_queues().

That was just an easy way to reproduce on both of my machines. Sorry.

