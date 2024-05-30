Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7326F31E
	for <linux-block@vger.kernel.org>; Thu, 30 May 2024 23:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717112332; cv=none; b=kc7YWf7RDYueT3dC9CxdPYt3pTNPSyccHqm+giGZYM0TqmLDivM5vYppcneJz77oQJdoBmFe3QwoDygK8sRWODSEdN8BYQw6PU2NnehbkDuWPuA3onrFdmoWpsWOgVolV9SURiNgOtnv/jHDQEmsiaf94QPK6FkIYHc425E+z/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717112332; c=relaxed/simple;
	bh=QUJSuy03ZNCBmwqJCUsiWVC2HAXMATM6ee7y40cP49E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgH2Jpz0Su5TLfmJsw3nz8XrpGPx0DlHPIXKoYr5+8XwRAwdHOZTkQd9qmKGIs6FMXW4mkOW0fbwGrGGIIv0uxn0SlsBWyglOvlA7seINNhq/G8keP5wqNG6vbf0eV52t55Lu2elJpaz+ZWeAsT/SVV5rhZrwSSclbNG3s8N2hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wvtZDYTb; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wvtZDYTb"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6f8e818d96eso142543b3a.0
        for <linux-block@vger.kernel.org>; Thu, 30 May 2024 16:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717112327; x=1717717127; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=azpfnJm0mug0EVvJB8AQ1srTjfoaqaqJ3tahTbkkpDE=;
        b=wvtZDYTbL6CojmshSbpr6LXZJeiQFQmj7RqJAAgc/DHR/TFC1T1DvTAMrLKPRrlKzy
         EIhm+1M8tvap2VsCRBEszh/0Ax0f2DAiqAGBF86NR+a8m36cRXqjhwsP6JL5IIeEtW6K
         z8FYlYyxTUeoEEkJLSyJfmzjOfvoHveLKaSDiI7G6oBOl60Tws5AxB2TKNjwLbyOusk5
         4/kKaq1NJUmbm3Cs4sebh2X26+WaJC+AcXrB6SHL55fYRtNzDzHcbFjubKWillSmLX4X
         suLYlw6j4dvbozMgQJ14qfDtA/U86KsJnaz775vd15I9K1gBdNgXq/D8QYyetdS3ygYm
         l66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717112327; x=1717717127;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azpfnJm0mug0EVvJB8AQ1srTjfoaqaqJ3tahTbkkpDE=;
        b=SlSzBG6FlEs2L3qAzlqC+4bRaxTITiVtYnCgN5vT2vc05YhU5EL3XKhPplCGaY8ink
         3XjNo7saHQoM2QaCbKA0AQm70O0kpeOCczYPRToNYc6X7CQkQYU7DKYFfbWQYYbg77jN
         nIftT3gwh5vZQxlNbPdk7I/DDZUtZH50Hz1uMfN0uhkOamMdojiANhXlppm9UvbVikE8
         A+3SZkHwUeTN90kjKOXe9LI837+HEzpZFk8qhZojF7WDAhUQ7leiEEm77H3IapBOEiOM
         2+laIcMk6mgqhkkoqbWxzvo+Hc989j+GLZDJ+I0deHySjO0jr09gYg0bmKZ4BPsyKxmU
         lsDg==
X-Gm-Message-State: AOJu0YzRYSYe+hOjB2OjhSv+kxN/12zETfZ+3+O10bNuyO9IT6CqR1TA
	3j/1vxfkVq+IiA1O8wtyPgIMTiBv0ct9zQF8N/bOIxcCBROHRKREtX8bMM1pkG8=
X-Google-Smtp-Source: AGHT+IFKTaIPWnYyei/5f5JIhUPPRBKl9ci5wgcU4MsOZw89htXm+bNFXqSj2haXAanHAvF0qe2dHA==
X-Received: by 2002:a05:6a00:8b18:b0:6f8:582e:6edf with SMTP id d2e1a72fcca58-702477bd88cmr317811b3a.1.1717112327061;
        Thu, 30 May 2024 16:38:47 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7024967ae05sm13924b3a.157.2024.05.30.16.38.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 May 2024 16:38:45 -0700 (PDT)
Message-ID: <7a69eba2-42e4-4c67-8a54-37b5b41675f9@kernel.dk>
Date: Thu, 30 May 2024 17:38:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7] block: Improve IOPS by removing the fairness code
To: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
 Yu Kuai <yukuai3@huawei.com>
References: <20240529213921.3166462-1-bvanassche@acm.org>
 <Zljl3kAfL0WfFkoZ@kbusch-mbp.dhcp.thefacebook.com>
 <a5c1716f-b21b-42d2-8ce3-13627566c754@acm.org>
 <Zljs7Arkq9nBrHLQ@kbusch-mbp.dhcp.thefacebook.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zljs7Arkq9nBrHLQ@kbusch-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/30/24 3:17 PM, Keith Busch wrote:
> On Thu, May 30, 2024 at 02:02:20PM -0700, Bart Van Assche wrote:
>> Thank you for having run this test. I propose that users who want better
>> fairness than what my patch supports use an appropriate mechanism for
>> improving fairness (e.g. blk-iocost or blk-iolat). This leaves the choice
>> between maximum performance and maximum fairness to the user. Does this
>> sound good to you?
> 
> I really don't know, I generally test with low latency devices and
> disable those blk services because their overhead is too high. I'm
> probably not the target demographic for those mechanisms. :)

Yeah same. But outside of that, needing to configure something else is
also a bit of a cop out. From the initial posting, it's quoting 2.9%
gain. For lots of cases, adding blk-iocost or blk-iolat would be MORE
than a 2.9% hit.

That said, I'd love to kill the code, but I still don't think we have
good numbers on it. Are yours fully stable? What does the qd=1 test do
_without_ having anyone compete with it? Is the bandwidth nicely
balanced if each does qd=32? I'm again kindly asking for some testing
:-)

> I just wanted to push the edge cases to see where things diverge.
> Perhaps Jens can weigh in on the impact and suggested remedies?

Don't think we have enough data yet to make the call...

-- 
Jens Axboe

