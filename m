Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F361FF603
	for <linux-block@vger.kernel.org>; Wed,  5 Mar 2025 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741165133; cv=none; b=A6zqh9w3W2HdzJxnBzwf0NlLwKFNE1ZaprMXyacDlC345SrqefWQ1bh4mZorvOAuaK/mg7539j8WHJNtUk7sYawDh7RqUdYW4sq0q/1sbJOfcdR3Lt/TswMzf2SvtKu6wtvIQf5teeZITLjGNfHbg12TGGEdMKOU0bmkbU0LIvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741165133; c=relaxed/simple;
	bh=XIRVC0J6oKvscF+Xt4WTls6FCopnEmH99bIVg7DwCAA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vgwm+HI/lpRczzIfnrfeg0/Srv2IYFj9Q68NkrPywvTt05dfzTK+OENjUXJmEJHG2fWrtkiKaoiAibZyrSRDoWt0HMF05ql2VsycKUZN7LRQTtt8G3l1+YCxBKEeewYPtuAGlWRJQq/WIbhT40Pca6+7vvbRosKTZdnBoH4bNas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QBN2RoNq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyQxrt2U; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=QBN2RoNq; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jyQxrt2U; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QBN2RoNq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyQxrt2U";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QBN2RoNq";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jyQxrt2U"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 75C361F76B;
	Wed,  5 Mar 2025 08:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741165124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OftoI1DB4cvJjGkzyU+iWO8yuvHidyReureSIR4PIs=;
	b=QBN2RoNqesTQzH9mRSX/z7LKlelWfeVkZ0rpOvRRFOCUIKzCbz5qCW+Cixz6q8Nky8r52O
	0Z+JcVUOnSZ0dLZ0HVo+c2sOnl+vmax7pMtHjJnHMHjdJq5+xf7g8Lc1XOCEi2O7Wkg7EO
	Pm8U5i8pIAvN3bJUQD4AJJv6k39dbNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741165124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OftoI1DB4cvJjGkzyU+iWO8yuvHidyReureSIR4PIs=;
	b=jyQxrt2UtYe/Q15ojvONj4DeFt8UD8ievHqBWOrk3c4Ud+bcSwU70l10ykm+xSVjjhBrou
	/oHsda5GOedkosAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=QBN2RoNq;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jyQxrt2U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1741165124; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OftoI1DB4cvJjGkzyU+iWO8yuvHidyReureSIR4PIs=;
	b=QBN2RoNqesTQzH9mRSX/z7LKlelWfeVkZ0rpOvRRFOCUIKzCbz5qCW+Cixz6q8Nky8r52O
	0Z+JcVUOnSZ0dLZ0HVo+c2sOnl+vmax7pMtHjJnHMHjdJq5+xf7g8Lc1XOCEi2O7Wkg7EO
	Pm8U5i8pIAvN3bJUQD4AJJv6k39dbNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1741165124;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1OftoI1DB4cvJjGkzyU+iWO8yuvHidyReureSIR4PIs=;
	b=jyQxrt2UtYe/Q15ojvONj4DeFt8UD8ievHqBWOrk3c4Ud+bcSwU70l10ykm+xSVjjhBrou
	/oHsda5GOedkosAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 51AA613939;
	Wed,  5 Mar 2025 08:58:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yfeOE0QSyGdyYgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Wed, 05 Mar 2025 08:58:44 +0000
Message-ID: <d6e65c4c-a575-4389-a801-2ba40e1d25e1@suse.cz>
Date: Wed, 5 Mar 2025 09:58:44 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Kernel oops with 6.14 when enabling TLS
To: Hannes Reinecke <hare@suse.com>, Hannes Reinecke <hare@suse.de>,
 Matthew Wilcox <willy@infradead.org>
Cc: Boris Pismenny <borisp@nvidia.com>,
 John Fastabend <john.fastabend@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <Z8XPYNw4BSAWPAWT@casper.infradead.org>
 <edf65d4e-90f0-4b12-b04f-35e97974a36f@suse.cz>
 <95b0b93b-3b27-4482-8965-01963cc8beb8@suse.cz>
 <fcfa11c6-2738-4a2e-baa8-09fa8f79cbf3@suse.de>
 <a466b577-6156-4501-9756-1e9960aa4891@suse.cz>
 <6877dfb1-9f44-4023-bb6d-e7530d03e33c@suse.com>
 <db1a4681-1882-4e0a-b96f-a793e8fffb56@suse.cz>
 <Z8cm5bVJsbskj4kC@casper.infradead.org>
 <a4bbf5a7-c931-4e22-bb47-3783e4adcd23@suse.com>
 <Z8cv9VKka2KBnBKV@casper.infradead.org>
 <Z8dA8l1NR-xmFWyq@casper.infradead.org>
 <d9f4b78e-01d7-4d1d-8302-ed18d22754e4@suse.de>
 <27111897-0b36-4d8c-8be9-4f8bdbae88b7@suse.cz>
 <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <f53b1403-3afd-43ff-a784-bdd22e3d24f8@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 75C361F76B
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[nvidia.com,gmail.com,kernel.org,grimberg.me,lists.infradead.org,vger.kernel.org,kvack.org,oracle.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

On 3/5/25 09:20, Hannes Reinecke wrote:
> On 3/4/25 20:44, Vlastimil Babka wrote:
>> On 3/4/25 20:39, Hannes Reinecke wrote:
> [ .. ]
>>>
>>> Good news and bad news ...
>>> Good news: TLS works again!
>>> Bad news: no errors.
>> 
>> Wait, did you add a WARN_ON_ONCE() to the put_page() as I suggested? If yes
>> and there was no error, it would have to be leaking the page. Or the path
>> uses folio_put() and we'd need to put the warning there.
>> 
> That triggers:
...
> Not surprisingly, though, as the original code did a get_page(), so
> there had to be a corresponding put_page() somewhere.

Is is this one? If there's no more warning afterwards, that should be it.

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 61f3f3d4e528..b37d99cec069 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -182,9 +182,14 @@ static int sk_msg_free_elem(struct sock *sk, struct sk_msg *msg, u32 i,
 
        /* When the skb owns the memory we free it from consume_skb path. */
        if (!msg->skb) {
+               struct folio *folio;
+
                if (charge)
                        sk_mem_uncharge(sk, len);
-               put_page(sg_page(sge));
+
+               folio = page_folio(sg_page(sge));
+               if (!folio_test_slab(folio))
+                       folio_put(folio);
        }
        memset(sge, 0, sizeof(*sge));
        return len;

