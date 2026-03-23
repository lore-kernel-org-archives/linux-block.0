Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF8E24CEEA;
	Mon, 23 Mar 2026 15:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279006; cv=pass; b=cZcEC+rQ/jwJj/qrZQo4rex6wKVSGgFfA4ynkuZpbrQMYrKpQTdt0Rz5YeWiZnLjoCbrhwAMMgPw4qkwXIDkfB740mKOl+HT1p9QH7tsoVUflWr/E6J/FKrRpALBlpoESBYD7BGMm0PEOREQniroj7vvfy3mUOTFXQCPMQD9YZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279006; c=relaxed/simple;
	bh=Efhjtp0APHmK3K9OuiG3mT/JRTCx6Z6YLMqTHztfeXA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Z7Pnrybg7/WIPZVHuqodd6p86kZtK6m0UvaACP6R2Df3/mDLiJZ81+H85sb/3kHqORgfdrm6QpMzCrpsYEt9dy0pmpMWGYtmZUY39kRgNMNynwT8thFEZIie9lJ9MngPHnchrsoxhG0wpJT2E3ZscB2ON9y1sX30m37ynyTxEMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Ej0NmHHI; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Ej0NmHHI"
ARC-Seal: i=1; a=rsa-sha256; t=1774278991; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=NqsTc3ZJJyigeXu519WqsnbWqhhcjh1It5TAJrn/i/UxA7gQ/kkalZgRLAXjVdrrfUsJTJtWSTIR0Gvf0PTFQynwqvSFkQOqXISFhSMeKA0+Ue+O+TK4vWP/tKuSZI/jYWAQsP2goLMGMNHAAt96uJDiSTof6CkaRRnC/j8Nwg8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774278991; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6R6h2nPCW6/5Ti/l+o6nr4dWLFSlaRLqeUUlVkl8Mu4=; 
	b=jPqXduo46Yf3aqnI+1OOG8+F2DGVqHhWsekwBOYI2gemnqBeF0hKJKjXzFZj3va4/23Iut1fyXyz8IS139ILyiLBxUN3hJiMxZypk5AwYUse3Vk/ZdjkpQvq1QJwCFv8h7W5eO2TmhmEQKSjindTNblOms61SBXi2lULywrgO6E=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774278991;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=6R6h2nPCW6/5Ti/l+o6nr4dWLFSlaRLqeUUlVkl8Mu4=;
	b=Ej0NmHHIUJPmdBozM2Sl51UPqtfKHw4chSOkQadPYVzUKXVk96un8nqtnkwPJN3U
	GwfumdM+wjZZ/Pu2l3b6uM7C2WBbmsCpPM+dela7zVt830TpM5Nx+BrdH6Jyg9BvlLd
	tKFqW+1Dq9zb1kndiS+Py6/wG38gti8Gg33bNH/Q=
Received: by mx.zoho.eu with SMTPS id 1774278989700420.2170527576808;
	Mon, 23 Mar 2026 16:16:29 +0100 (CET)
Date: Mon, 23 Mar 2026 15:16:22 +0000
From: Josh Law <objecting@objecting.org>
To: Christian Brauner <brauner@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/7=5D_lib/iov=5Fiter=3A_fix_misplaced_?=
 =?US-ASCII?Q?parenthesis_in_iov=5Fiter=5Frestore=28=29_kvec_check?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260323-wirtschaften-mittragen-5217e168da05@brauner>
References: <20260313181038.30018-1-objecting@objecting.org> <20260313181038.30018-4-objecting@objecting.org> <20260323-wirtschaften-mittragen-5217e168da05@brauner>
Message-ID: <6876729A-2510-4C02-AD84-63C7B587A48C@objecting.org>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External



On 23 March 2026 12:39:10 GMT, Christian Brauner <brauner@kernel=2Eorg> wr=
ote:
>On Fri, Mar 13, 2026 at 06:10:34PM +0000, Josh Law wrote:
>> When restoring a kvec-backed iterator after a short write in a kernel
>> socket sendmsg path (e=2Eg=2E an NFS client resending an RPC call), the
>> WARN_ON_ONCE guard fires a spurious warning on every first call=2E
>>=20
>> The closing parenthesis of WARN_ON_ONCE is after !iter_is_ubuf(i),
>> leaving !iov_iter_is_kvec(i) as a separate && operand outside the
>> macro:
>>=20
>>   WARN_ON_ONCE(!bvec && !iovec && !ubuf) && !kvec
>>=20
>> For kvec iterators this evaluates as WARN_ON_ONCE(true) && false =E2=80=
=94 the
>> warning fires but the return is skipped, so execution proceeds correctl=
y=2E
>> The warning is the only visible symptom, but it is confusing and may
>> mask real issues=2E
>>=20
>> Found through code review of the operator precedence in the condition
>> expression and confirmed by tracing the macro expansion=2E
>>=20
>> Move the closing parenthesis to include the kvec check inside
>> WARN_ON_ONCE so the warning only fires for genuinely unsupported
>> iterator types=2E
>>=20
>> Signed-off-by: Josh Law <objecting@objecting=2Eorg>
>> ---
>>  lib/iov_iter=2Ec | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>=20
>> diff --git a/lib/iov_iter=2Ec b/lib/iov_iter=2Ec
>> index 325669b103ed=2E=2E6a7959bfc849 100644
>> --- a/lib/iov_iter=2Ec
>> +++ b/lib/iov_iter=2Ec
>> @@ -1471,7 +1471,7 @@ EXPORT_SYMBOL_GPL(import_ubuf);
>>  void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state=
)
>>  {
>>  	if (WARN_ON_ONCE(!iov_iter_is_bvec(i) && !iter_is_iovec(i) &&
>> -			 !iter_is_ubuf(i)) && !iov_iter_is_kvec(i))
>> +			 !iter_is_ubuf(i) && !iov_iter_is_kvec(i)))
>>  		return;
>>  	i->iov_offset =3D state->iov_offset;
>>  	i->count =3D state->count;
>
>Look=2E=2E=2E the placement is intentional as is easily identifiable by
>looking at the history of the commits=2E This clearly is AI generated
>and you don't have the capacity at the moment to meaningfully argue or
>present the technical changes you are proposing - if you are an actual
>person at all=2E As such I see no reason to engage with this=2E



1: i am a real human
2: For code written by AI, i use Assisted-by: , i wrote the commit descrip=
tion with ai (thats why its so long)


Sorry for wasting your time

V/R


Josh Law
