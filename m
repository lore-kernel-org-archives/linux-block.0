Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7B4207A01
	for <linux-block@vger.kernel.org>; Tue, 18 Mar 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742309259; cv=none; b=b4c+SILmeog7h2PJr1FHokH8oZgXsyD9/Y+fCT2oglKa56FQvlm6P0989/jJ82UfmzDeaJbzKVjeumRINQGoAxH+S9wJEAaCZy/k8V/Atm9zw2st+MKJp07l/2l3pJywaX+rKy38nzO+7sx+DczaR3DUsDcnm4f7rOyzCryfOy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742309259; c=relaxed/simple;
	bh=ediSkZbFO8cLr6v3uIjGalEku4S/35CAsxnb+CySAI4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Cm9vi6dUPfTi2+BytSR7vGczwG0kT7m3/Wzy9mIoVG44L6XP7W6YHvTNWqRMGb4r7uBPrmaYddAlOTLy1RxFIOg4154/fvp55hYxgFfCZLh2HAXkM2CIFlZ634Y+5A1SQXpVmXyG3+sSg1Q3cFI1ChoqzhTiqBoFAqdbkg7vKrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N800DWQ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DHtBjx8f; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=N800DWQ3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DHtBjx8f; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N800DWQ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DHtBjx8f";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="N800DWQ3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DHtBjx8f"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 20A0E21CF1;
	Tue, 18 Mar 2025 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742309252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuTy5ZnujrVlIBE4yq+8qTVYdJOQQjxbYdVG9eEf09Y=;
	b=N800DWQ3JcfJ+4/pVM01NhjzzW1TZdAt7KlLZIRsb29tVbFN2U68YV0DR3NrX84cMkYecM
	WMQlfKf6t/1gWKjdeK9FLfirzT1+WoQT5z9lMPpTjNThoZO/c21c0qn5NTO0LQor94mOwV
	vuthJFQxiwqAZ3R3NAvIcmKqK7B2jXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742309252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuTy5ZnujrVlIBE4yq+8qTVYdJOQQjxbYdVG9eEf09Y=;
	b=DHtBjx8f+YF1ZwMSbIPRZ3PdLKsGKMUR5CHzuc5WYZlcbdHzOb3FIbB79gS1BgnrVNPHxb
	2AmmKVVve6pxKdDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1742309252; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuTy5ZnujrVlIBE4yq+8qTVYdJOQQjxbYdVG9eEf09Y=;
	b=N800DWQ3JcfJ+4/pVM01NhjzzW1TZdAt7KlLZIRsb29tVbFN2U68YV0DR3NrX84cMkYecM
	WMQlfKf6t/1gWKjdeK9FLfirzT1+WoQT5z9lMPpTjNThoZO/c21c0qn5NTO0LQor94mOwV
	vuthJFQxiwqAZ3R3NAvIcmKqK7B2jXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1742309252;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TuTy5ZnujrVlIBE4yq+8qTVYdJOQQjxbYdVG9eEf09Y=;
	b=DHtBjx8f+YF1ZwMSbIPRZ3PdLKsGKMUR5CHzuc5WYZlcbdHzOb3FIbB79gS1BgnrVNPHxb
	2AmmKVVve6pxKdDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1059C1379A;
	Tue, 18 Mar 2025 14:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cDeJA4SH2WfsEgAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 18 Mar 2025 14:47:32 +0000
Message-ID: <2a2e5822-d8a6-4460-b92a-01d113e18ead@suse.de>
Date: Tue, 18 Mar 2025 15:47:31 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Matthew Wilcox <willy@infradead.org>, lsf-pc@lists.linuxfoundation.org,
 linux-mm@kvack.org, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>
From: Hannes Reinecke <hare@suse.de>
Subject: [LSF/MM BPF Topic] Warming up to frozen pages
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid]
X-Spam-Score: -4.30
X-Spam-Flag: NO

Hey all,

(Thanks, Jon, for the title :-)
the recent discussion around frozen pages and when to do a 
get_page()/put_page() and when not resulted in quite some unresolved issues.
So I would like to propose a session at LSF/MM:

'Warming up to frozen pages'
With the frozen pages patchset from Willy slab pages don't need
(and, in fact, can have) a page reference anymore. While this easy
to state, and to implement when using iov iterators, problems
arise when these iov iterators get mangled eg when being passed
via the various layers in the kernel.
Case in point: 'recvmsg()', when called from userspace, is being
passed an iov, and the iterator type defines if a page reference
need to be taken. However, when called from other kernel subsystems
(eg from nvme-tcp or iscsi), the iov is filled from a bvec which
in itself is filled from an iov iter from userspace, so the iov
iterator will assume it's a 'normal' bvec, and get a reference for
all entries as it wouldn't know which entry is a 'normal' and which
is a 'slab' page.
As Christoph indicated this is _not_ how things should be, so
a discussion on how to disentangle this would be good.
Maybe we even manage to lay down some rules when a page reference
should be taken and when not.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

