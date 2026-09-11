Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A5325F7A9
	for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 13:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789133929; cv=none; b=ryzrSFBXlDms9XJNj6zcaCKN4R4g5nUOB2/0uy7OCokQRsxxnvB+seRpJUnI2ulybo2Fb4SUUbJOyYVSkg10ZxKepa+ol65Ngzxy/vNkPS5IHTiBR/kR5IiQRJSK+symB+OCShGLolH8U8nOfSnBxNIIpfP3DlqF6uKoYPcqHwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789133929; c=relaxed/simple;
	bh=5SC3HT3+5ycGwWh5KBASibBcRAJzdLO3KnH4sjbmFDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SHCOzDlezdBzwFBhBY+cCA1acTH1pFMFM3NrB2WvL3aOfTGMVVP7l+Hp9xtn4zOwv7Mz/KF4QUuqnL3qn9rYzlpOpvZsAKoM/p36LhRmqZIhDOF6RhptTvbOMy1ppShLcAXNyF3coxM2epp+nJveipdfhs2jncWGc2ses71N6Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=sD9i0EPj; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="sD9i0EPj"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7f57db8b5a4so841419a34.2
        for <linux-block@vger.kernel.org>; Fri, 11 Sep 2026 06:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1789133926; x=1789738726; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sCKlIYEc3WBtqZTRSmkKr4C+yXpeMrWNJb+k5yI49J0=;
        b=sD9i0EPjj0Ig68IeGg90WglA7IXGd9HwDQFuhbJxnkZjB9Si4yn+4RIQak7mynH8zH
         +1igcCeXsxwsXgponQPQcytQjaWGZlR66ar561qN73PpPOlr9uGsjcgjobCPKB/avnlv
         a6LoshCKEOCyssaM+uYy0Rz5r8mafFkENxpBEAhYYNyTBGSrJ2MW1OIYtHElh1gFbyeS
         25eZHFxVSNu4fZY/OuFp1yh2tYbwRN9s8O9Uj3iLNMsZMMstNEZ+LW7X1oDFuiHn3V1Z
         zR3n/XKfT4kjiRHGzC/hy2wBLC4+VjYpRg05efGSlP9DZfjmhocxWk6aScfTYbWrKgFU
         RHKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789133926; x=1789738726;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sCKlIYEc3WBtqZTRSmkKr4C+yXpeMrWNJb+k5yI49J0=;
        b=QLV44QD+O5WnGh/1VgJCISQzLFdW9pZlGQy9YkfaIEtHE6/9sA9fqGDLvF5HAh0b6l
         hZG5MdpWz5vw5XVNG7Qed1T4NtZH9KHOOmp7zNpcbjdPGLZj1ia4IBbEdi6R2NonV7an
         Z3LGy0iUmrsX5v/0pw8g3oyk0xB0Gsr8ZFkNGeE4je9p4FgdrzjDX5BnHQaxP14z4WhF
         tlgNS6/7OX9UZp2ruF4vSHGWkNfDYTBNNtW03elLwOff0EPmAdZUXBqI+if7Gsnyk8za
         p1RYLz4DfrV1n/ifabKim9xQIXVv6Y0VnXgKX0IXkltiEbfP4LFKSxQv7lwTlHmxHvf2
         HDhg==
X-Forwarded-Encrypted: i=1; AKwUvBwRXu+cX/AYA22217aPrL84QQNQLzBkZeQNG9b+hJIV1Fa9n5oIzRUc/+Ev3t3+kEIBmgbcSbb7ZtHrnA==@vger.kernel.org
X-Gm-Message-State: AFuF++l+RQU4s72lOGMsms0m1lovrXTjkSeVx9y84N3M6K46pEQfTSwB
	fzU8JLl+6BgNkB/nGY/V+G2HursW3vyEIXpOSI4/tzLzp0wpjfWokpR60oJ0q2KgAMA=
X-Gm-Gg: AYBFou3Yc3JpLE/1f82Dy49kBwOXLd0rm5MiAI0z8EhuzZ6MClIiokl7J3YXn07sLhL
	r3gAwsj1ruW2AkALR9O4dsU30f2hDiWvStl4G8g9imGcURmcNrMZ+hn9EMKViih2E/i2eXKznHU
	p2byMhbLe+4PcZkewzYOnSPRF9wzgAfHLxnxtci3bLKnMBG8D72ulY4CqHZRcfvVicjLZtXSG8e
	+vXyzWAeW5Sy4CrwuJsf+uL65SqeTLfxRnihRhGoD0naOF7eh7lRZTnjtS+CODSGEOBqgxpgb64
	6VXJhNKEVUUJ0siEsdmfSLHryadNMSCOz2tPz6dqwCmA1BkwHj+LqXgyDRqm6Xocxos9RCk3avQ
	JXRlMdBX4BAvOujmVYtELHcUkNHVFY81nVlPRlg8PXtWcDUlqOexbgotC/lBo0URK6NqMDA0wti
	9HOfG9IvuQYTkWGp3BAjTwuKsp3xyAmtIsbSLzfEj7Sz+zpj6a99X/ec0qCISSyTiNPxaJF/sw+
	NXwNvoymdOYr6TbCNaBIMNyDSQhnCBlQfyYOMqKB7UtvlhtgZlFHyYz
X-Received: by 2002:a05:6830:7314:b0:7ee:19dc:b00 with SMTP id 46e09a7af769-803fd2514b3mr3323405a34.3.1789133925938;
        Fri, 11 Sep 2026 06:38:45 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-8051005d845sm206965a34.24.2026.09.11.06.38.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 06:38:45 -0700 (PDT)
Message-ID: <2325107b-8c45-4304-aaa5-f8c768d619bf@kernel.dk>
Date: Fri, 11 Sep 2026 07:38:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lazy bounce buffering for checksummed reads v3
To: Christoph Hellwig <hch@lst.de>
Cc: Christian Brauner <brauner@kernel.org>,
 "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Tal Zussman <tz2294@columbia.edu>, Anuj Gupta <anuj20.g@samsung.com>,
 linux-block@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20260909060924.1102037-1-hch@lst.de>
 <fe537c5f-114d-4d9a-817d-93f359e12924@kernel.dk>
 <cff350b3-836f-4953-97f3-d664164746b4@kernel.dk>
 <20260911114438.GA21957@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260911114438.GA21957@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/11/26 5:44 AM, Christoph Hellwig wrote:
> On Thu, Sep 10, 2026 at 02:51:33PM -0600, Jens Axboe wrote:
>>> It's a little hard to split as you have eg block patches both at the
>>> start and beginning... In the spirit of getting this some runtime, I'm
>>> going to queue it up in a separate branch,
>>> for-7.4/lazy-bounce-buffering for now.
>>
>> On 2nd thought since this already relies on stuff in the XFS tree
>> apparently, you can just add my
>>
>> Reviewed-by: Jens Axboe <axboe@kernel.dk>
>>
>> to the block patches. Would probably make everybody's life easier.
> 
> No, the current series is just on top of mainline with the block
> fixes for Sashiko existing issues comments split out.  Which probably
> was a mistake, as that now lead to a side-discussion and Sashiko can't
> apply it any more because it is too stupid to parse the cover letter.
> 
> I guess I'll do another resend with the two of those that stick
> included, and I'll leave the third on to John, who already has a
> handle on it.

OK, I've got it in for-7.4/lazy-bounce-buffering now.

-- 
Jens Axboe
