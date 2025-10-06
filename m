Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8F61F3FF8
	for <linux-block@vger.kernel.org>; Mon,  6 Oct 2025 23:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759791807; cv=none; b=Giatae5HT0x3WHRoQEqcbnuNmqr0ritvU0Qg0kbAwbmsjundAumvciVGqSgsa5mywkEPkgxPtZVxkGgcCZU907UIn0QPfhmoc24fIfIMc0OzY+z+0vbxXVLpsLlp7PlH+dsuBjeWR3b5qa8Vd1fAgotCtuTS/bnnrqn+1Eutbbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759791807; c=relaxed/simple;
	bh=/Ai/7CXD6I4InkkM/H6YZi8skp/FKhTv3iQ1U2MW7KE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pw5gkYizEbVv5YBPSrDuJS/ptrJNc8sTm9Hzbgn9kDyervoLgwBZ135/YGQWYBDyOu5COnwCbi3nEUAiv+ggorCyFO/BEtsJ1yjHq1bK3Z6E0ERaEmFewKO8A1GL5qQXp7dKRr2DTbR1NmrwY/6P8HHSmwldtNFZCPv0c2j+Q9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=gsDuqWuD; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="gsDuqWuD"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-42e7b22e007so17218625ab.3
        for <linux-block@vger.kernel.org>; Mon, 06 Oct 2025 16:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1759791802; x=1760396602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UhKOB1LeZ+mbxoao/sRZ8yxswtEf+MPffXFWfBjnldQ=;
        b=gsDuqWuDyOy0PDgWR/Xqx1vHmUST8CPmUyE/ciimLbJVtTJUf02T4JEuj5shc+V85N
         OObEuXkCp8nCMtad10QeDMDq4rsxwOjQMjtxYuEIVrUclep9nSTSCH+aDcN7pow2OlfP
         VmwQ76pC/jxlSU5KKKezNbTUTMuWM0dmQbt41PcNEJVauJ+XNuZqL475YqsB/8tG1Kup
         /BMRO+7pVovlzJqKS4Gxx2aSssqfkoWu69IimajsS2lTBEfhxqcCWukjeX868SVCYihF
         LheBDzZfN0Y3uqo8nGTAxiHm+50IrOemqDcU2VS9B8d6XQry3c+spidDdf4vyR7Yvazw
         KSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759791802; x=1760396602;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UhKOB1LeZ+mbxoao/sRZ8yxswtEf+MPffXFWfBjnldQ=;
        b=e6vehlmk94Qy4rB5O8wlLnd6CRdMvjyjJJmajC7mWYNYtg3Bn7E5WS0kRhUYuy/psy
         LODvbFPd+k2k/sC+nbk0Pck5IxnVOfBySI50Q6pr7kkVAjxswIOLi/Vvp/VEaWAB4FHE
         YUZnk7sk09QrT5cO5qhhAH58ks/rHQECZ87n6kWZqKUmUoIEFF2zOPJyGh8tGnPRH/RB
         GPuTjcXieRjAPVoisGwz9GtbKjE093k/U5H21KweyMcXlyMt1wzXhU0Rb1vngPY7G+Ek
         e1qTfIzwdvuq7ZkTbmW13i1oxPpZEPJt2LS8Ydklx+1h27FESUI6Ws8qSxLHl8fAG6f2
         tLTQ==
X-Gm-Message-State: AOJu0Yybzn92tQdXBqq117MWKWCGrzhd6TXNzmJZNzkM0NkrkE/QKdMw
	vhq0X/Ms3nZP0Ij/dGmfbhKRdLphaw34w7ziSUnRZJ4NcWIZyK7ks1jKN+e3hHXzUNw=
X-Gm-Gg: ASbGnctjuQp6fGf2Wa23FpGsenBXtyjSFImeENIovM+lcluGQ1QWKIMrF5aT60IWNZY
	WnqlaVv01b+oofdjpOkLC2Si8SIUDs9FXeL6uuB/Yt5y833A5O7LtCVwH+AvuTgjxurivTaqOMX
	9gxS1gGdBjWAz7DSUVegqoGeryU2kLL+3CufqOmEOma5xJYfgZEowj/QeFgwVpqM9TQcdAPrgYb
	/S/XVSNWCMquI8SFq+12KJg1epXa0DeVIP3g/AAhHW+M6G9BAkIobNIplSc26LYM8LsjCSx85BM
	2sBaOAXqvSZygi+I7Glu6jTbh1y1kut69do/u5t7dXLyillsb5XIfH7cVxf5sMo0U2BMvSJhQs3
	Okyx7V/GyrKfwi1nbb4y9dUIesLyTuXI4pig+HpoYuY2i
X-Google-Smtp-Source: AGHT+IFZki8yvjWv0uD3MZa7HW3OsFV/V9Dt5t19qdy0NZq9NMgc+HgsCv9T6/dPQODY9Y8Dxfff9g==
X-Received: by 2002:a05:6e02:164f:b0:42a:f84b:9e7f with SMTP id e9e14a558f8ab-42e7ad95e38mr204069925ab.15.1759791801853;
        Mon, 06 Oct 2025 16:03:21 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec07eaasm5137984173.53.2025.10.06.16.03.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Oct 2025 16:03:21 -0700 (PDT)
Message-ID: <07dbe66c-86d4-4a2d-ab7d-e0a351b3ae9f@kernel.dk>
Date: Mon, 6 Oct 2025 17:03:19 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/5] blk-mq: Replace tags->lock with SRCU for tag
 iterators - Rockchip UFS regression
To: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
 Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Yu Kuai <yukuai3@huawei.com>, kernel@collabora.com,
 linux-rockchip@lists.infradead.org
References: <20250830021825.2859325-1-ming.lei@redhat.com>
 <20250830021825.2859325-6-ming.lei@redhat.com>
 <pnezafputodmqlpumwfbn644ohjybouveehcjhz2hmhtcf2rka@sdhoiivync4y>
 <CAFj5m9Ki1U6N4N6-=HYy49KfvYAbegmwcXLuKCxjX4E+qy7u7Q@mail.gmail.com>
 <4f16e17d-796b-4896-9d4c-6d227514f1ca@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <4f16e17d-796b-4896-9d4c-6d227514f1ca@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/6/25 12:02 PM, Bart Van Assche wrote:
> On 10/4/25 7:42 AM, Ming Lei wrote:
>>    One possible fix is to check hba->scsi_host_added before calling
>> scsi_host_busy():
>>
>>    dev_err(hba->dev, "%d outstanding reqs, tasks=0x%lx\n",
>>        hba->scsi_host_added ? scsi_host_busy(hba->host) : 0,
>>        hba->outstanding_tasks);
> 
> My preference is to add a check inside scsi_host_busy(), e.g. as follows
> (entirely untested):
> 
> diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
> index cc5d05dc395c..17173239301e 100644
> --- a/drivers/scsi/hosts.c
> +++ b/drivers/scsi/hosts.c
> @@ -611,8 +611,9 @@ int scsi_host_busy(struct Scsi_Host *shost)
>  {
>      int cnt = 0;
> 
> -    blk_mq_tagset_busy_iter(&shost->tag_set,
> -                scsi_host_check_in_flight, &cnt);
> +    if (shost->tag_set.ops)
> +        blk_mq_tagset_busy_iter(&shost->tag_set,
> +                    scsi_host_check_in_flight, &cnt);
>      return cnt;
>  }
>  EXPORT_SYMBOL(scsi_host_busy);

Agree, that's a nicer way to solve it, putting that stuff outside
of actual drivers.

-- 
Jens Axboe

