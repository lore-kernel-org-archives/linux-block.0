Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D642725DAE3
	for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 15:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741705231; cv=none; b=h+WMx6jttWIVhhrFZR0v5YXDtZP6FjtKTSLNb7/fBZPQh1cHm6HLBM6ehnYAs9z6+BgIDv4qJpr226z2NtWuKGAbwwmIwUTYhITjglIFVeqLWN/SzSKQyWoVGIEj8rXnCTlcgw39ZKSQnHbvHooExjZ5UgA5vXPbhEfXhgeFhf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741705231; c=relaxed/simple;
	bh=vXvSVuV5bQhF3VLG2iUhLPtLfSzlkVdCIse4Udo9Qqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e6GSz2UMVhBzbuEVKRn96EKkq5lmxGj/nvZUReuRtd3yAuCWKvJOpS5kwFhOviVX5twQbLH9thOfc9z4go3WmPsF5lecbBRLlx/TorRBSgbn5AUKrxOL5dNvUgDCDYDlaYx3JQLB21JTkuI16joyKVe4awnO25t2H0MtZ/gJqfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=WZ+xq9Ds; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="WZ+xq9Ds"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-3d2a869d016so13630065ab.0
        for <linux-block@vger.kernel.org>; Tue, 11 Mar 2025 08:00:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741705228; x=1742310028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAEFP7CPGRpGB6Ek/yG/+ONndvVAbW/tO0SLyNQeThQ=;
        b=WZ+xq9Dsm9jeqzZzAAySxJoKM52wRcxaQ+uEMDHkz5aSTTpV8APZaM9tuAdu+4hcHd
         WcobedaDT4U5GluAzd+qRbVG7oVISBbAyOCdATmmvALDU6+KYdJTxD6BknMLY2ryGUM6
         oQbKyZz0mOeN2tRGI4Sdusum8trZv53eXFhSc0tjqmfdikT2X29VMRpIwbWtQIVOFedI
         pWItSNOAtFj2S2QLnSOTdjqOqbj8oPjbdvRdwcRklh4ssPBUHBHfBTXNpWw6RoPLTJIJ
         zRH865EJkk3y2nMvhKKRiXi4sUoWl1N02n/F59SsU08baDD92ll4dkhf9NtMgF/7oBms
         xCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741705228; x=1742310028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAEFP7CPGRpGB6Ek/yG/+ONndvVAbW/tO0SLyNQeThQ=;
        b=G9UWM/utf+vdQAeLWouX3lYOB7YhTi9e8HW1tEZUvpfk4qjDQRjdUKukaptZGgnQOb
         3Bx7FPUNHs9/DAaI8URnTLOeBd3mAFVQBuIaMf2HGPKlPpYp1XGPu9/6W2uDoThJR+SG
         Mi2q5Axmks8ly8/XoH/D/GgtI5vZ+oFgXjdmvPxF6VxDqjeBnDOk8cQTQZtJlDQ60GHV
         DkY4DNyxmXRM2obHgb7Hd8KJpV+Dke1w9u/POq8LXMnOqt61p6iTo84bPhwLvuIn06Fl
         89K2LzTYkTvq7v0GrqkbdIcJ14OCiEdbvAj8UDO3eW9PKcPjyeHahwr7LgKh4quqe5EM
         oFLA==
X-Forwarded-Encrypted: i=1; AJvYcCWibPGutO9PaLPeScSNM3A32jsZ4MOLHwDi9EKJud9ZVHoGp9v54BoHJAJlJXkdwRU7jJCvrgw26aB8vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YybszRfXCcl1XTJUd9IHXp1XEPk+j/QD5CzVy2CYDrpfR8efh02
	Q36OAHeDmna0XzbKiX9CR6rODD6fpyyouuc0bGEwlhpZfoWBH5AzHGCkW1YF2Ek=
X-Gm-Gg: ASbGncsJjueD0ddK6yGwIjMKsVRbxG83xBb1y1Qb8k0uCDYQ4ApQdZR9B5K+LgRQVul
	Ddbt+6wcCyL0O9l+rU13Cbkp0nMxoNG8ZxtNAaD4hep79Of9fbKfQlZX4M1/yBmdU8oP3Xemyim
	Mex8gwRjpv3qVNckn6g+t6ke3VgNpLV4NFqjT4F3QFvh/EX4EyQhZUURVphq2SZLcLnBVD6mcko
	0P0UoLG2KOXRsTGfK2yoEaepvavtZdNv8VD2ZW3jjNYt/ogML12kIWVx/EDka4GvlL1iQqpa/dC
	HFwii7dVQYQhENpFj/4FkarcGiZ6o6XlnnJ75aaK
X-Google-Smtp-Source: AGHT+IHcxmWKlhT5BUMzUPM9EJYkbnyAI4b58WPXYjPQE+KohkFz2IdZ3dWWXwc9yjWqAMtIkD2flQ==
X-Received: by 2002:a05:6e02:378e:b0:3d3:fa64:c6ed with SMTP id e9e14a558f8ab-3d44196906cmr183046915ab.7.1741705227480;
        Tue, 11 Mar 2025 08:00:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3d46ef68116sm732055ab.40.2025.03.11.08.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 08:00:26 -0700 (PDT)
Message-ID: <625382fc-8503-4e19-b571-6245fb4d1317@kernel.dk>
Date: Tue, 11 Mar 2025 09:00:26 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: cleanup and fix batch completion adding conditions
To: Milan Broz <gmazyland@gmail.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 Ondrej Kozina <okozina@redhat.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Alan Adamson <alan.adamson@oracle.com>
References: <20575f0a-656e-4bb3-9d82-dec6c7e3a35c@kernel.dk>
 <71bbd596-a3a0-4e37-baae-19f02c6997be@redhat.com>
 <459b9c3b-0d5e-4797-86f7-4237406608ff@kernel.dk>
 <535ff54b-5c49-42f0-af5f-020169b5da79@redhat.com>
 <d84313c6-3dd1-446d-910d-e7f9f2e7d53c@gmail.com>
 <3irisb67klhv2xu3w5digf2tavrbnn2umthcgkbgrpfs3effnd@f3btiynduuox>
 <cdc19799-fc72-4581-a942-adf411b19a94@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <cdc19799-fc72-4581-a942-adf411b19a94@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/11/25 8:59 AM, Milan Broz wrote:
> On 3/11/25 4:03 AM, Shinichiro Kawasaki wrote:
>>
>> I created fix candidate patches to address the blktests nvme/039 failure [1].
>> This may work for the failures Ondrej and Milan observe too, hopefully.
> 
> Hi,
> 
> I quickly tried to run the test with todays' mainline git and mentioned two patches:
>   https://lkml.kernel.org/linux-block/20250311024144.1762333-2-shinichiro.kawasaki@wdc.com/
>   https://lkml.kernel.org/linux-block/20250311024144.1762333-3-shinichiro.kawasaki@wdc.com/
> and it looks like our SED Opal tests are fixed, no errors or warnings, thanks!
> 
>> Jens, Alan, could you take a look in the patches and see if they make sense?
> 
> Please, fix it before the 6.14 final, this could cause serious data corruption, at least
> on systems using SED Opal drives.

Fix is already queued up.

-- 
Jens Axboe

