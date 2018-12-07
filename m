Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4D1C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 12:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C01E720892
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 12:13:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C01E720892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cnexlabs.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbeLGMNz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 07:13:55 -0500
Received: from mail-eopbgr710050.outbound.protection.outlook.com ([40.107.71.50]:49888
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbeLGMNz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 7 Dec 2018 07:13:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cnexlabs.onmicrosoft.com; s=selector1-cnexlabs-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+VqwuHMVeEO9e9uDsHiKeVrPHspnvwYh/S8v9u1cvk4=;
 b=dAcrTGGD1j2iydWTVNDCE31xsQ+REPTASOeJ5yEf7yE1wcVUQN/gunEBajcQSwVe5EVti6zLFiP67HMRWrQpgZVkrWiAKergPcxWFBbzCMs1UD/iD7akL+WS1yltD6UjmcekDvv0YXYt8nFKVDW0+pGGiBaedB1uMQrRbjw6JMI=
Received: from DM6PR06MB5178.namprd06.prod.outlook.com (20.178.25.19) by
 DM6PR06MB6201.namprd06.prod.outlook.com (20.178.225.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1404.19; Fri, 7 Dec 2018 12:13:50 +0000
Received: from DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c841:4bd1:3b20:e7ea]) by DM6PR06MB5178.namprd06.prod.outlook.com
 ([fe80::c841:4bd1:3b20:e7ea%4]) with mapi id 15.20.1404.021; Fri, 7 Dec 2018
 12:13:49 +0000
From:   Javier Gonzalez <javier@cnexlabs.com>
To:     =?utf-8?B?TWF0aWFzIEJqw7hybGluZw==?= <mb@lightnvm.io>
CC:     "Konopko, Igor J" <igor.j.konopko@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hans Holmberg <hans.holmberg@cnexlabs.com>
Subject: Re: [PATCH 2/2] lightnvm: pblk: Ensure that bio is not freed on
 recovery
Thread-Topic: [PATCH 2/2] lightnvm: pblk: Ensure that bio is not freed on
 recovery
Thread-Index: AQHUjXuU53X24u9Ju0aGLrIsj6MreaVy/xyAgAAvpwCAAALhgA==
Date:   Fri, 7 Dec 2018 12:13:49 +0000
Message-ID: <8DCB397C-5A0E-4E85-AEDF-70A8603FC7EF@cnexlabs.com>
References: <20181206154559.5642-1-igor.j.konopko@intel.com>
 <20181206154559.5642-2-igor.j.konopko@intel.com>
 <A790DB4E-9DD0-40CE-94D9-631E0C28D2D6@cnexlabs.com>
 <0f219bd6-fd49-5d13-f0e2-af8fe7749127@lightnvm.io>
In-Reply-To: <0f219bd6-fd49-5d13-f0e2-af8fe7749127@lightnvm.io>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=javier@cnexlabs.com; 
x-originating-ip: [193.106.164.211]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR06MB6201;6:W7lLiQRYywAjAa3VdIbOM1m5JLVNipVVCZk9A18kfR5OP+1N9+7GKXGBxD+Y8Ixvn3t188RjoJMaWgWI3cW2VE5UaHNYfKRc8K7+cV99LIdvbOFB/4uduIhsLoJlpHlceALAZf9bm/3SYD1guACQdZn7kCcldT3ITdKQhagkyKlCnNFQ8j43ty2u+Wmu7M4hWAZUaRFEaLGZHmFe6bgWDwWVxB0wPChexKNDWmdXl/P8AVjUnVYlK3Eu+PsLFmcEgWUd4Ecn/tsPmFmqLc+uEMus8mSngi5AGqP73sMUHqHroIJgbEUjb599B7SOTcLz4YqVWroOTHg1V1WVTaAD061OiOWZIvJi8MJFV3r3Id+W35QB4EPBTl/jk7m5YU8s2PumQPoApmQBEeaKrzTa0PZu2/Gfl9D3P4yr+2U0kH8nwnTf29CMN/2QYgQg5FKKop3wEXnKIbTm7vuNiIabYg==;5:SwkY8m10ud62Kvdl3GPm1gr1qVCV9NSapBbkkOqZnZd+pidxAOXlbsw9OJDdzlHbP/2AbDwD5fYkDzg0CmQkInM3bzqP98Xm/+RwBpUWo38GpZHrh/bWOsA+qJN+zzaR8Srnlv7cGaHYS7yzMmTeYzpurKtvns5dfaJRgEDiSBs=;7:Kt87bwYjjNRaiXM7EyWhXXevPnAXvy02CUCXlIscIYNXvGth83gqoKZYGcZXhmsfK64XvusXIVpofw2nB5TU8+IAq/l0Dq+vq09spc0rzcMk85sWRUxiqzHO+bXQouurUZZiX0u0MxSgzzuGzOPCDg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(136003)(376002)(396003)(346002)(39840400004)(366004)(199004)(189003)(316002)(6916009)(25786009)(81166006)(54906003)(7736002)(2906002)(53936002)(305945005)(68736007)(6116002)(229853002)(36756003)(3846002)(93886005)(107886003)(14454004)(6246003)(4326008)(99936001)(8676002)(26005)(33656002)(86362001)(81156014)(5660300001)(102836004)(186003)(66066001)(83716004)(76176011)(99286004)(478600001)(6506007)(8936002)(53546011)(82746002)(486006)(6486002)(256004)(106356001)(6436002)(71190400001)(71200400001)(97736004)(11346002)(2616005)(476003)(446003)(6512007)(105586002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR06MB6201;H:DM6PR06MB5178.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 61418272-5a37-4854-fb3c-08d65c3d71f9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(49563074)(7193020);SRVR:DM6PR06MB6201;
x-ms-traffictypediagnostic: DM6PR06MB6201:
x-microsoft-antispam-prvs: <DM6PR06MB62012F3C4D7365B95CACDEE0BAAA0@DM6PR06MB6201.namprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(102415395)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231455)(999002)(944501520)(4983020)(52105112)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:DM6PR06MB6201;BCL:0;PCL:0;RULEID:;SRVR:DM6PR06MB6201;
x-forefront-prvs: 0879599414
received-spf: None (protection.outlook.com: cnexlabs.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: JuZ79CEE7EO+DYAa7K7g194R50l9ioj3CyiAI+agGEVGeXLWzGAdqwMNVGxlQ5pX1N3TbKCuFbNELXbnmtKQ9iUSxa1TZlJUQMJa2uSiyZLII6WD0S2aR8beafzZRLvSF0/RK+Kv7Cce1JkOIZ3Xm+ERBTtA1guoqCdIW9Mw8BdiwZ104q27zDgjYOOsE7IJrTwtEZgJMGjr2SMn+If1XsM1dZW4lPFoBYB8kcMDWhk5VnsHsidjA9E+ItebjArpP5rTvdTaiaqE5sifgPC9kjxWTQrnUI/trzppThKzLRK+go2AAvfu3Eqafny6VaTpPumzi2LLSlIvl6S7Tw/VDikMz5bmJ60Klf3xEoUTFgg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: multipart/signed;
        boundary="Apple-Mail=_55AA6382-35A3-4B0C-A9D2-FBDEC1A75786";
        protocol="application/pgp-signature";
        micalg=pgp-sha512
MIME-Version: 1.0
X-OriginatorOrg: cnexlabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61418272-5a37-4854-fb3c-08d65c3d71f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2018 12:13:49.3378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e40dfc2e-c6c1-463a-a598-38602b2c3cff
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR06MB6201
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--Apple-Mail=_55AA6382-35A3-4B0C-A9D2-FBDEC1A75786
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8


> On 7 Dec 2018, at 13.03, Matias Bj=C3=B8rling <mb@lightnvm.io> wrote:
>=20
> On 12/07/2018 10:12 AM, Javier Gonzalez wrote:
>>> On 6 Dec 2018, at 16.45, Igor Konopko <igor.j.konopko@intel.com> =
wrote:
>>>=20
>>> When we are using PBLK with 0 sized metadata during recovery
>>> process we need to reference a last page of bio. Currently
>>> KASAN reports use-after-free in that case, since bio is
>>> freed on IO completion.
>>>=20
>>> This patch adds addtional bio reference to ensure, that we
>>> can still use bio memory after IO completion. It also ensures
>>> that we are not reusing the same bio on retry_rq path.
>>>=20
>>> Reported-by: Hans Holmberg <hans.holmberg@cnexlabs.com>
>>> Signed-off-by: Igor Konopko <igor.j.konopko@intel.com>
>>> ---
>>> drivers/lightnvm/pblk-recovery.c | 12 ++++++++++--
>>> 1 file changed, 10 insertions(+), 2 deletions(-)
>>>=20
>>> diff --git a/drivers/lightnvm/pblk-recovery.c =
b/drivers/lightnvm/pblk-recovery.c
>>> index 009faf5db40f..3fcf062d752c 100644
>>> --- a/drivers/lightnvm/pblk-recovery.c
>>> +++ b/drivers/lightnvm/pblk-recovery.c
>>> @@ -376,12 +376,14 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 		rq_ppas =3D pblk->min_write_pgs;
>>> 	rq_len =3D rq_ppas * geo->csecs;
>>>=20
>>> +retry_rq:
>>> 	bio =3D bio_map_kern(dev->q, data, rq_len, GFP_KERNEL);
>>> 	if (IS_ERR(bio))
>>> 		return PTR_ERR(bio);
>>>=20
>>> 	bio->bi_iter.bi_sector =3D 0; /* internal bio */
>>> 	bio_set_op_attrs(bio, REQ_OP_READ, 0);
>>> +	bio_get(bio);
>>>=20
>>> 	rqd->bio =3D bio;
>>> 	rqd->opcode =3D NVM_OP_PREAD;
>>> @@ -394,7 +396,6 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	if (pblk_io_aligned(pblk, rq_ppas))
>>> 		rqd->is_seq =3D 1;
>>>=20
>>> -retry_rq:
>>> 	for (i =3D 0; i < rqd->nr_ppas; ) {
>>> 		struct ppa_addr ppa;
>>> 		int pos;
>>> @@ -417,6 +418,7 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>>> 	if (ret) {
>>> 		pblk_err(pblk, "I/O submission failed: %d\n", ret);
>>> 		bio_put(bio);
>>> +		bio_put(bio);
>>> 		return ret;
>>> 	}
>>>=20
>>> @@ -428,19 +430,25 @@ static int pblk_recov_scan_oob(struct pblk =
*pblk, struct pblk_line *line,
>>>=20
>>> 		if (padded) {
>>> 			pblk_log_read_err(pblk, rqd);
>>> +			bio_put(bio);
>>> 			return -EINTR;
>>> 		}
>>>=20
>>> 		pad_distance =3D pblk_pad_distance(pblk, line);
>>> 		ret =3D pblk_recov_pad_line(pblk, line, pad_distance);
>>> -		if (ret)
>>> +		if (ret) {
>>> +			bio_put(bio);
>>> 			return ret;
>>> +		}
>>>=20
>>> 		padded =3D true;
>>> +		bio_put(bio);
>>> 		goto retry_rq;
>>> 	}
>>>=20
>>> 	pblk_get_packed_meta(pblk, rqd);
>>> +	bio_put(bio);
>>> +
>>> 	for (i =3D 0; i < rqd->nr_ppas; i++) {
>>> 		struct pblk_sec_meta *meta =3D pblk_get_meta(pblk, =
meta_list, i);
>>> 		u64 lba =3D le64_to_cpu(meta->lba);
>>> --
>>> 2.17.1
>> Both patches in this series look good, but since they are fixes to =
the
>> patches you sent for this window, I would suggest that you merge them
>> into the original set and resend. We can then test the series again =
and
>> make sure there are no regressions from V1.
>> Matias: would this work for you? The current series in your branch is
>> broken as is.
>> Thanks,
>> Javier
>=20
> I've applied 1 (v2) separately since it did not merge cleanly with the
> lightnvm: pblk: add helpers for OOB metadata patch. 2 has been merged
> with the "lightnvm: pblk: support packed metadata" patch.

Cool. Thanks. We will tests if this fixes the regressions on V4.

Javier

--Apple-Mail=_55AA6382-35A3-4B0C-A9D2-FBDEC1A75786
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+ws7Qq+qZPG1bJoyIX4xUKFRnnQFAlwKY/wACgkQIX4xUKFR
nnRqGBAAk0GFVoXfYLJVpu52d+QfndtbDcCkqtvnpS0u3haXA+qTEEnQQdcfw81Y
qyilX24zAl+JYKa91RQaQYfB6C5Du6IT6fhD5+cRs7g9vwDV0NzvLAR7bj/1uLhV
wpVOsq308OsegWa6vG3lXVha46uM4BmIEDdTGoV+Gkeo8Lxpow5wV1j4bUKcrjLg
Tp2+qHzrblzR3Truwgekd+4yWDNK65bivwEncyom5A2LhbPvf/NXF74JST4yEhZU
PYr8aAeXCD0lB9V+It7ZqWjMMH7P8RvxhkZtm+n9cYPDvzJI7hNMAlubz+35/LWK
BH50eZGJnn7uCt02ex25tGnwLAZmhkztqO/aYcLUYVxR2Mxwdw9V96Bb6olSphPD
hE0Oh9zoCStP5vF+/Vmw0wPXWO05wP8XXHFzfoBn6Ulj4u3TLwXZIIcHKgqf8wIN
IUa4UZE048IUnbimWa6BH99AduIjlMlt9XoI36wUeoSjF0ppOlH7YWSpkoEClDu4
mhyxyjhIfAKL8AnP5QQysdIjcS3+XutCmQkizCLy6Fz/Er9M4kyWYC+kk5kyqcnH
TZ2gwnQJyn59H7J6davn2No7BKBRL1Y23qumAUCtJKFvfQ/rGUhugDRvSkoafUYF
3eosroiJAPI8gPbt8RMhIFt/qTq5FcBtMNU/pBByd/2eIEpnUCo=
=JCuv
-----END PGP SIGNATURE-----

--Apple-Mail=_55AA6382-35A3-4B0C-A9D2-FBDEC1A75786--
