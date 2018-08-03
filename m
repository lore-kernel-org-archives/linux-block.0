Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-eopbgr720072.outbound.protection.outlook.com ([40.107.72.72]:35776
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728343AbeHCPZ0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 3 Aug 2018 11:25:26 -0400
From: Javier Gonzalez <javier@cnexlabs.com>
To: =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lightnvm: pblk: take write semaphore on metadata
Date: Fri, 3 Aug 2018 13:28:48 +0000
Message-ID: <DC0080D0-BB8B-45C6-9CF8-CAE451F6CEB4@cnexlabs.com>
References: <1533297919-27253-1-git-send-email-javier@cnexlabs.com>
 <ff9b6206-8316-dd48-4df3-73b122e3afd3@lightnvm.io>
In-Reply-To: <ff9b6206-8316-dd48-4df3-73b122e3afd3@lightnvm.io>
Content-Type: multipart/signed;
        boundary="Apple-Mail=_3BE8BAEE-974C-4490-B92B-0BE999DD006E";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

--Apple-Mail=_3BE8BAEE-974C-4490-B92B-0BE999DD006E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 3 Aug 2018, at 14.45, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 08/03/2018 02:05 PM, Javier Gonz=C3=A1lez wrote:
>> pblk guarantees write ordering at a chunk level through a per open =
chunk
>> semaphore. At this point, since we only have an open I/O stream for =
both
>> user and GC data, the semaphore is per parallel unit.
>> Since metadata I/O is synchronous, the semaphore is not needed as
>> ordering is guaranteed. However, if the metadata scheme changes or
>> multiple streams are open, this guarantee might not be preserved.
>> This patch makes sure that all writes go through the semaphore, even =
for
>> synchronous I/O. This is consistent with pblk's write I/O model. It =
also
>> simplifies maintenance since changes in the metdatada scheme could =
cause
>> ordering issues.
>> Signed-off-by: Javier Gonz=C3=A1lez <javier@cnexlabs.com>
>> ---
>>  drivers/lightnvm/pblk-core.c | 14 ++++++++++++--
>>  drivers/lightnvm/pblk.h      |  1 +
>>  2 files changed, 13 insertions(+), 2 deletions(-)
>> diff --git a/drivers/lightnvm/pblk-core.c =
b/drivers/lightnvm/pblk-core.c
>> index 00984b486fea..160b54d26bfa 100644
>> --- a/drivers/lightnvm/pblk-core.c
>> +++ b/drivers/lightnvm/pblk-core.c
>> @@ -493,6 +493,16 @@ int pblk_submit_io_sync(struct pblk *pblk, =
struct nvm_rq *rqd)
>>  	return nvm_submit_io_sync(dev, rqd);
>>  }
>>  +int pblk_submit_io_sync_sem(struct pblk *pblk, struct nvm_rq *rqd)
>> +{
>> +	if (rqd->opcode !=3D NVM_OP_PWRITE)
>> +		pblk_submit_io_sync(pblk, rqd);
>> +
>=20
> Why should the write be issued twice?
>=20

It is the read that is sent twice, that's why it does not fail. Rebased
the patch manually and messed up... should be return... I'll send a V2.

Javier

--Apple-Mail=_3BE8BAEE-974C-4490-B92B-0BE999DD006E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAltkWI0ACgkQIX4xUKFR
nnSyZxAA3o90wct5QuotIp3eJs8dfDjyByXERkS6Xta3uPgW6Iw6RcnerT9wBXH8
Tz7pzC6ZiP2fSKKjo9RO/2RUBGeW5j1ERoe1BAsNac6CHJnMyNws1YtzXXKY2Hpa
2GlzIgtzlcEvGNWwjI0pz2C8+r1Z+033WstSKcOMDnl1EhuonsSD3jpRA0HSkGgu
gAHY4egE1YeMfuEzDVSH5aJOCH6v9ZJzSDMwpe9lVlfPNiWGbUw4mR0pcdOhNk+u
mleWXTENrw8uzhic1HhtosN/BrvcAr4W+9v/76KeHxjgLdZ9toIyD4qF1ASIhRpS
v2VcBnXckA+nURm4jFeHXrkeQEp1X03dCoTs/p1KwvKz9qWmdh8xMD9ADRmFchRN
IA3S4jEdVWLKZirM1bgYVQGiMqes+LN9BL2qEZq7lf747dthiciXYcOsz2u9E68d
w+A7OqM2GgJWbJ13SeS8ZVcgk0H/xhDyq853zs+QYmWJ9rxKR73gfKwlGH28YFib
hv6A5nGB/QcAlwmJoGHbNst6o2+/ELShq+HEHiWHInfJThAtQ1NLSyOJcGqOGN81
rbwruVXCDLxU9U/6H/3VSyIiKJ15/Y5r/3QJfLQDSgcpJPL8N8r1NhbIrWstdjlx
uKuQuP6YEqdVfJ0yuHayeTuaMNx1dDbgDrdbKKw8BL+bR++lz6w=
=scBG
-----END PGP SIGNATURE-----

--Apple-Mail=_3BE8BAEE-974C-4490-B92B-0BE999DD006E--
