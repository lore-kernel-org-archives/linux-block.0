Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA7326924
	for <linux-block@vger.kernel.org>; Mon, 23 Feb 2026 16:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864826; cv=none; b=Ox2umszQmwEssW72Ayu04ow3uyd38/Rcq0eSrzJK+MVSMXR9ZkcUn1hhuV9/Qpx7128isl4nI+HVMj/il2yI2YBLtrAReAG6Ljrd8PARClkNsBm1wQiKgPuY1KjvFGfzJecH0pOXixj571q0g5TP+i1ny6qDM36B2xU6nVyBeqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864826; c=relaxed/simple;
	bh=I7lUptFxVarzef9jC3UnmMrsKEqQ87c/rhGjl8OYvuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1yBYn6lqQnczeQ6um+xdULL+lLdpKt5zuzNgHzvrQx/F2PvhdufUFWdQWhqtZEO6Q2zoo0kYLSLleCeXY9WhlJZE/NK12dqWTLXG1tM3wuGYRAIe8ehw/eIcN3OMmus3ykIs1J0fzdHfOZKpRwhUEzlMNUF4QSwe8gn3xJtAp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jJNau3c3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YAieF/w4; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jJNau3c3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YAieF/w4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jJNau3c3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YAieF/w4";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jJNau3c3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YAieF/w4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AC13E5BE67;
	Mon, 23 Feb 2026 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771864823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgb3ZEft8H8vg1RtznkOIulf8Ony0/O/bgWiqx7t8as=;
	b=jJNau3c3QbBeEjRBRcwAI9fCcEF1t50YJsiqUKSmWEcWjw0yp+Z1pREyeebONaKdRk+nva
	+BiZdFXRsgDcGAz5dqE9QDTq4DC4nfRpPaeQ+3mHs66T7LX4lJrQBaTLCD16CJ47tY5f4Q
	WhmXWfNH5HrBJbBmiDZPN6jnhT/NVr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771864823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgb3ZEft8H8vg1RtznkOIulf8Ony0/O/bgWiqx7t8as=;
	b=YAieF/w45cdAl7C34WmMAd+L6Iodz2kTKV5NQUmDBvlgLy4i8sm0cksQ5k2RF0xMgFS7vD
	kxgdbsBHeMDX/qDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771864823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgb3ZEft8H8vg1RtznkOIulf8Ony0/O/bgWiqx7t8as=;
	b=jJNau3c3QbBeEjRBRcwAI9fCcEF1t50YJsiqUKSmWEcWjw0yp+Z1pREyeebONaKdRk+nva
	+BiZdFXRsgDcGAz5dqE9QDTq4DC4nfRpPaeQ+3mHs66T7LX4lJrQBaTLCD16CJ47tY5f4Q
	WhmXWfNH5HrBJbBmiDZPN6jnhT/NVr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771864823;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cgb3ZEft8H8vg1RtznkOIulf8Ony0/O/bgWiqx7t8as=;
	b=YAieF/w45cdAl7C34WmMAd+L6Iodz2kTKV5NQUmDBvlgLy4i8sm0cksQ5k2RF0xMgFS7vD
	kxgdbsBHeMDX/qDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 438413EA68;
	Mon, 23 Feb 2026 16:40:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id FEvaDveCnGl4fwAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 23 Feb 2026 16:40:23 +0000
Message-ID: <eb5c2bd8-9e59-496d-8480-29ae7c7b959b@suse.de>
Date: Mon, 23 Feb 2026 17:40:22 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
To: Pavel Begunkov <asml.silence@gmail.com>, Xiao Ni <xni@redhat.com>,
 lsf-pc@lists.linux-foundation.org, linux-block
 <linux-block@vger.kernel.org>, bpf@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
References: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
 <7e772d91-a546-40ed-90c0-29e2a9721c53@gmail.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <7e772d91-a546-40ed-90c0-29e2a9721c53@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lists.linux-foundation.org,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

On 2/23/26 16:54, Pavel Begunkov wrote:
> On 2/19/26 05:38, Xiao Ni wrote:
>> Hi all
>>
>> I'm doing some work on user-space RAID recently. I'd like to propose a
>> topic for LSF/MM 2026 regarding the implementation of RAID5 in user
>> space using ublk and io_uring bpf[1], particularly focusing on the
>> challenges encountered and potential kernel improvements needed.
>>
>> Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
>> with the goal of leveraging io_uring's zero-copy capabilities and
>> BPF[1] for performance optimization. The implementation includes:
>> * RAID5 stripe handling with configurable chunk sizes
>> * Multi-queue support via io_uring
>> * Degraded mode for single disk failure tolerance
>> * Integration with io_uring BPF struct_ops framework
>>
>> During the implementation, I encountered several technical challenges.
>> The primary challenge is performing XOR parity calculations in a true
>> zero-copy manner:
> 
> I aim at similar use cases, i.e. interacting with registered buffers
> from BPF, but based on a different BPF-io_uring implementation. I'd be
> interesting to discuss how the kfunc API should look like.
> 
I'd be interested in that, too.
I'm working on BPF support for nvme / nvmet, so some ideas how others
handle it won't go amiss.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
