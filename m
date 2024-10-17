Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84831D517F
	for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 15:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729178548; cv=none; b=qfmTHRWMxRXiRYzHeAGKoMnhEnv3Qzu4+XWcBafEu0T/ADSQ8hj7x7/fE1dQ3w215sUg29nrjXwY+nMPbdvLTic8nhtxw7orS/ixaC4zaQv8kslRCyDS4byVfFtE1UUkpWXQxBNUm+6zY7OTv/FOg69CMwaJX6EgVP9sDSbXDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729178548; c=relaxed/simple;
	bh=UaDPdCKKSSfF9NRflOSJISU3ZdOwCoup8uX+PASWICo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dkJSt5TxGtC4EBN+0t/Jg7wteAVGehIa3/LqaKV8uz26gmFzjGGw+FiBfTlUXUR2//grXJCOEH4iOqcKp7IwH8MtEO89zkylDwJhBvTJ1C9bR6sIRLGe23tnWN/1njAtBoi0w0mSBq0zPaU2TDqziN+eedj8yZyjM+jDgxvQu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pt4XhjpQ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pt4XhjpQ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7ea16c7759cso775493a12.1
        for <linux-block@vger.kernel.org>; Thu, 17 Oct 2024 08:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729178545; x=1729783345; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSoKGGiRCnZ9piV//RZWaZZil92WuLO/DhXTXz1F4CQ=;
        b=pt4XhjpQpW+Pwcg9DeVg1AKeSeMnF8bwsVGGG+MCmnGPOBUMcOLkColeNPGInJ99rc
         wrQrxpE5JBbdeVCSNOXtxxkz90kmTnGlSwIIRSSiOpUyzWPita5X2HL8E2F2FVIl3NBa
         bTRuCY24hbKd8508sAfU8X4uj7LHYNNX+L6DMpxC1TBalQB0n68AWwTU4gsc0utvjCba
         ejLnCaaThsNdJqlUAhFxACl8HiM1CAPE118pLFolkMwfMOaxU3VwrK7BtL2A51z8dtyS
         b99mmJeygw0L0qgOX43P1uist51cwq58ZzhxFLfFu1PCDx26jvqprzfnptyIydJq3qjr
         grVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729178545; x=1729783345;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSoKGGiRCnZ9piV//RZWaZZil92WuLO/DhXTXz1F4CQ=;
        b=lK+EjjWkzcZ/NJ27vhWN+yo7M6Bcoi4KMHeg1bkCxLyF2VMzKR8tph+zP9gIVEwegx
         /cOijxzJ5xc0IUmHWuGqPqp8Z+qhW/7K6kltBucHZozvZfF5PSFonDuausnYIkTMe602
         YY5Wu8qfkoGmBRFJuIEYO/ONm+MldrHbDYobZZ3cpvZ9kPFNRnWjUUv8rtueiNzek2W6
         FF+9ftDQoJj18EV5CSeHTWTkRVB3cijjuMiIt38yrVHkSQXNCVUCq2jQ1gekmR8ocKmB
         K4PMuZWBxLbCN3LTc9vwE2bk6USHWcEWNjAYTX83bVp9AKopClCehN7vO3f9fZk2mf2+
         aedQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHie3QSt1+mYVlYXnNRhhAktjfs4Qje+ie3fRCBjDu3eTPxgWCYZpBvP2+VW/EyT7ydL4wrVbXiVAMGA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwNkW3SS3PKBHIlJX+GOTT0A2d6ngel1+Af6fin+Ts/Pu9fuFjg
	tmNJPRUJOh+K6YoYh14kM5J3V3IwztI8UlnpkgitptleyybsHVKql9Ib04IWCT0=
X-Google-Smtp-Source: AGHT+IENU8Fr8yFzAl4iBhNeQFbxQre3LkDc6Ik49pVYvphrxavalgR2L35/luMRfY5ekKuaIxmvrQ==
X-Received: by 2002:a05:6a21:1789:b0:1c4:9f31:ac9e with SMTP id adf61e73a8af0-1d8bcfc21f5mr31655417637.42.1729178545042;
        Thu, 17 Oct 2024 08:22:25 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ea9c707839sm5064130a12.69.2024.10.17.08.22.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Oct 2024 08:22:24 -0700 (PDT)
Message-ID: <140c4437-fea2-482b-a43f-4ffe6c35e3d2@kernel.dk>
Date: Thu, 17 Oct 2024 09:22:22 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: fix partial sending
To: Bart Van Assche <bvanassche@acm.org>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org
Cc: josef@toxicpanda.com, nbd@other.debian.org, eblake@redhat.com,
 vincent.chen@sifive.com, Leon Schuermann <leon@is.currently.online>,
 Kevin Wolf <kwolf@redhat.com>
References: <20241017113614.2964389-1-ming.lei@redhat.com>
 <354b464e-4ae0-460b-b6d1-8ae208345bfa@acm.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <354b464e-4ae0-460b-b6d1-8ae208345bfa@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/24 9:13 AM, Bart Van Assche wrote:
> On 10/17/24 4:36 AM, Ming Lei wrote:
>> +static blk_status_t nbd_send_pending_cmd(struct nbd_device *nbd,
>> +        struct nbd_cmd *cmd)
>> +{
>> +    struct request *req = blk_mq_rq_from_pdu(cmd);
>> +    unsigned long deadline = READ_ONCE(req->deadline);
>> +    unsigned int wait_ms = 2;
>> +    blk_status_t res;
>> +
>> +    WARN_ON_ONCE(test_bit(NBD_CMD_REQUEUED, &cmd->flags));
>> +
>> +    while (true) {
>> +        res = nbd_send_cmd(nbd, cmd, cmd->index);
>> +        if (res != BLK_STS_RESOURCE)
>> +            return res;
>> +        if (READ_ONCE(jiffies) + msecs_to_jiffies(wait_ms) >= deadline)
>> +            break;
>> +        msleep(wait_ms);
>> +        wait_ms *= 2;
>> +    }
> 
> I think that there are better solutions to wait until more data
> can be sent, e.g. by using the kernel equivalent of the C library
> function select().

It's vfs_poll() - but I don't think that'd be worth it here, the nbd
driver sets BLK_MQ_F_BLOCKING anyway. Using a poll trigger for this
would be a lot more complicated, and need quite a bit of support code.

-- 
Jens Axboe
