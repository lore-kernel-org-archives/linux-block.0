Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0624B1BE85C
	for <linux-block@vger.kernel.org>; Fri, 16 Aug 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723824750; cv=none; b=C52bReVE5b5KZP6cl5EcBRDWFYlW+Bn4NMIb7E4f2ZwSvWuS8d6yDFIp2IUDLRDsmY5RdAzl+gTgsfYquizC1NLwBILGoGgmW7E/eDKuxNz4QTSUw82pqZ4etmb7pH67eRvfwrFgptVIzn01gRGQfEymp0YW0X5hahw9sNo7b4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723824750; c=relaxed/simple;
	bh=wgeJia9bjdiNDXCX3q482jNRCcsVA80+lDPe86g7+YA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DTxFgMWWZezXEHw/GRL9skBHy9Ul7kd9jktBh+Vc/HPgt4q71ILKNA7YwzF+miHFfUJ8XNGQIjbp5DM456ciN+wBQ0IJxEpYyZ6K9yh2cdeRwi5XmNke5CBCO1ykko2igKEjfoeZVUhvDTYsbuYQbuR4yODBTnOw0aBlvrYe8ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LHDvZUpt; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LHDvZUpt"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47GCTfRc002675;
	Fri, 16 Aug 2024 16:12:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:reply-to:to:cc:date:in-reply-to
	:references:content-type:content-transfer-encoding:mime-version;
	 s=pp1; bh=u0r69LUg5vLyZ30neeYD6QcQzQ8qLxsvmEJOsTxP/l4=; b=LHDvZ
	UptmI2pegfbx5TFrF9bJYB0RPxvadA7qpCTvdzoCAqh78fgHt2L5NvYuD7kUP4jJ
	wbRdoRvxHS+6QTbWLWTRPW9VWW0na7wA9XIHzBzyTtw2EI2SE4elScRyl28f5907
	hByTL2onOa8GDIOxOdG43pgRGro3h85aaQyzlK1CgdBUQJjJh/7lt1YTrPzpQ5Z0
	eI9OGO2+iTgWf5FirFAK60mwzugH4u5l1OsGlzMtTw8H/do2KmqcDNh2QY1FSa/N
	2gwy1sc/hEzMEwxy52JuqKFBTHXo22eL0rnNoe5aMUGHOFqBNBokrFwGw5aADfOr
	tF4J/tkq580cl6a/w==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6s6h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 16:12:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47GD0w52020896;
	Fri, 16 Aug 2024 16:12:16 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 40xn83m0ex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Aug 2024 16:12:16 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47GGCDfe28312078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 16:12:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F37058058;
	Fri, 16 Aug 2024 16:12:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3755858057;
	Fri, 16 Aug 2024 16:12:13 +0000 (GMT)
Received: from rhel-laptop.ibm.com (unknown [9.61.43.239])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Aug 2024 16:12:13 +0000 (GMT)
Message-ID: <1d566fa1305d80d3704af6d4159658f13f10c590.camel@linux.ibm.com>
Subject: Re: [PATCH 1/1] block: sed-opal: add ioctl IOC_OPAL_SET_SID_PW
From: Greg Joyce <gjoyce@linux.ibm.com>
Reply-To: gjoyce@linux.ibm.com
To: Michal =?ISO-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc: linux-block@vger.kernel.org, axboe@kernel.dk, jonathan.derrick@linux.dev
Date: Fri, 16 Aug 2024 11:12:13 -0500
In-Reply-To: <20240816154021.GX26466@kitsune.suse.cz>
References: <20240816153557.11734-1-gjoyce@linux.ibm.com>
	 <20240816153557.11734-2-gjoyce@linux.ibm.com>
	 <20240816154021.GX26466@kitsune.suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4NebHTeKKCsAYuuAO6tj4cFHdmz5U97z
X-Proofpoint-GUID: 4NebHTeKKCsAYuuAO6tj4cFHdmz5U97z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_09,2024-08-16_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxlogscore=848
 phishscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408160111


Yes, I'll have a pull request for nvme-cli later today or Monday at the
latest. The changes will be dependent on IOC_OPAL_SET_SID_PW being
defined so that the cli isn't dependent on kernel version.

Greg

On Fri, 2024-08-16 at 17:40 +0200, Michal Such=C3=A1nek wrote:
> Hello,
>=20
> is there a corresponding change to an userspace tool to make use of
> this?
>=20
> Thanks
>=20
> Michal
>=20
> On Fri, Aug 16, 2024 at 10:35:57AM -0500, gjoyce@linux.ibm.com=C2=A0wrote=
:
> > From: Greg Joyce <gjoyce@linux.ibm.com>
> >=20
> > After a SED drive is provisioned, there is no way to change the SID
> > password via the ioctl() interface. A new ioctl IOC_OPAL_SET_SID_PW
> > will allow the password to be changed. The valid current password
> > is
> > required.
> >=20
> > Signed-off-by: Greg Joyce <gjoyce@linux.ibm.com>
> > ---
> > =C2=A0block/sed-opal.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 26 ++++++++++++++++++++++++++
> > =C2=A0include/linux/sed-opal.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 =
+
> > =C2=A0include/uapi/linux/sed-opal.h |=C2=A0 1 +
> > =C2=A03 files changed, 28 insertions(+)
> >=20
> > diff --git a/block/sed-opal.c b/block/sed-opal.c
> > index 598fd3e7fcc8..5a28f23f7f22 100644
> > --- a/block/sed-opal.c
> > +++ b/block/sed-opal.c
> > @@ -3037,6 +3037,29 @@ static int opal_set_new_pw(struct opal_dev
> > *dev, struct opal_new_pw *opal_pw)
> > =C2=A0	return ret;
> > =C2=A0}
> > =C2=A0
> > +static int opal_set_new_sid_pw(struct opal_dev *dev, struct
> > opal_new_pw *opal_pw)
> > +{
> > +	int ret;
> > +	struct opal_key *newkey =3D &opal_pw->new_user_pw.opal_key;
> > +	struct opal_key *oldkey =3D &opal_pw->session.opal_key;
> > +
> > +	const struct opal_step pw_steps[] =3D {
> > +		{ start_SIDASP_opal_session, oldkey },
> > +		{ set_sid_cpin_pin, newkey },
> > +		{ end_opal_session, }
> > +	};
> > +
> > +	if (!dev)
> > +		return -ENODEV;
> > +
> > +	mutex_lock(&dev->dev_lock);
> > +	setup_opal_dev(dev);
> > +	ret =3D execute_steps(dev, pw_steps, ARRAY_SIZE(pw_steps));
> > +	mutex_unlock(&dev->dev_lock);
> > +
> > +	return ret;
> > +}
> > +
> > =C2=A0static int opal_activate_user(struct opal_dev *dev,
> > =C2=A0			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct opal_session_info
> > *opal_session)
> > =C2=A0{
> > @@ -3286,6 +3309,9 @@ int sed_ioctl(struct opal_dev *dev, unsigned
> > int cmd, void __user *arg)
> > =C2=A0	case IOC_OPAL_DISCOVERY:
> > =C2=A0		ret =3D opal_get_discv(dev, p);
> > =C2=A0		break;
> > +	case IOC_OPAL_SET_SID_PW:
> > +		ret =3D opal_set_new_sid_pw(dev, p);
> > +		break;
> > =C2=A0
> > =C2=A0	default:
> > =C2=A0		break;
> > diff --git a/include/linux/sed-opal.h b/include/linux/sed-opal.h
> > index 2ac50822554e..80f33a93f944 100644
> > --- a/include/linux/sed-opal.h
> > +++ b/include/linux/sed-opal.h
> > @@ -52,6 +52,7 @@ static inline bool is_sed_ioctl(unsigned int cmd)
> > =C2=A0	case IOC_OPAL_GET_GEOMETRY:
> > =C2=A0	case IOC_OPAL_DISCOVERY:
> > =C2=A0	case IOC_OPAL_REVERT_LSP:
> > +	case IOC_OPAL_SET_SID_PW:
> > =C2=A0		return true;
> > =C2=A0	}
> > =C2=A0	return false;
> > diff --git a/include/uapi/linux/sed-opal.h
> > b/include/uapi/linux/sed-opal.h
> > index d3994b7716bc..9025dd5a4f0f 100644
> > --- a/include/uapi/linux/sed-opal.h
> > +++ b/include/uapi/linux/sed-opal.h
> > @@ -215,5 +215,6 @@ struct opal_revert_lsp {
> > =C2=A0#define IOC_OPAL_GET_GEOMETRY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 _IOR('p', 238, struct
> > opal_geometry)
> > =C2=A0#define IOC_OPAL_DISCOVERY=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 _IOW('p', 239, struct
> > opal_discovery)
> > =C2=A0#define IOC_OPAL_REVERT_LSP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 _IOW('p', 240, struct
> > opal_revert_lsp)
> > +#define IOC_OPAL_SET_SID_PW=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 _IOW('p', 241, struct
> > opal_new_pw)
> > =C2=A0
> > =C2=A0#endif /* _UAPI_SED_OPAL_H */
> > --=20
> > gjoyce@linux.ibm.com
> >=20

