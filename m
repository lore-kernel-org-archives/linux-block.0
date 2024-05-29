Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F221CD37;
	Wed, 29 May 2024 13:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716990819; cv=none; b=QDyG7igP4aGbufkp37Ff/MdgjBtF2HocXRKV4c8EGRQqRCl2IzAIsO+fVrhbfsGTmYkAqxWXguW5lmBfCBQGYN5IfASjvhqxzAPb4am6wqxPU7GxoJMnBCbRoV2NiW5t/4A1HnxlZSS5QnRglszBbPan1XC2NnJq8h5D9N3Rplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716990819; c=relaxed/simple;
	bh=y26ipyuX/ItBKpPRg/M7phcLUegsUUakBbPT+K6ItPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1Op3P8sODEQq3IUk3IRta3AGoxkld44ngRfowph90pa3ZraI6/hDsbaXluCp/A6VHFPrxqHHdbu+x7UJUStUWHtG4wBrMP1NzdaLl2doPJMlucd40l7uA31Fnz7LgzmcRFXGUzjn6cn7Trk6o1nstwtP4F1LzpcmSmPk1iQQY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44TAjcFv010057;
	Wed, 29 May 2024 12:49:39 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Dhpe.com;_h=3Dcc?=
 =?UTF-8?Q?:content-transfer-encoding:content-type:date:from:in-reply-to:m?=
 =?UTF-8?Q?essage-id:mime-version:references:subject:to;_s=3Dpps0720;_bh?=
 =?UTF-8?Q?=3DOkSHme8qRdc1oP9Z1/sJWLvkHwZYfQaTyyjWMYtmqVo=3D;_b=3DoRa/3eYu?=
 =?UTF-8?Q?LfuflX4ymkmcGxR8NOtDrbujU/fZgZBjCkxSWZbXLJiuZbLyckSiVIk3EVyW_hj?=
 =?UTF-8?Q?AydiTlGDAPITyoZVZz4D3t+E+yLhY6u9CD5dar/edlSmSFIQsxV13QpGEdGhDap?=
 =?UTF-8?Q?4fb_sB3G0g9w6/5dqb6Lgsp/4pL0cp2qveKPukVV1CpM2NsMMIpCOCBxeDUCZHh?=
 =?UTF-8?Q?1GJ7rdznp_N2H8nviRFCfcnRCVil8nXbIlssiMQW8MSsAXg097zQSjUUwFKqsc3?=
 =?UTF-8?Q?5G3Q05N7MLMw/lt_J/HAjVF9ctGkI8tYR9GZmgIc/iJDi7Z1jvhsT5k0wJWKDo8?=
 =?UTF-8?Q?X1DSg5R+w/GiFtVbW7RDC_ag=3D=3D_?=
Received: from p1lg14879.it.hpe.com ([16.230.97.200])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3ye1r59bvy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 12:49:39 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 63CFF12B5B;
	Wed, 29 May 2024 12:49:38 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTPS id 8936680172C;
	Wed, 29 May 2024 12:49:36 +0000 (UTC)
Date: Wed, 29 May 2024 07:49:34 -0500
From: Dimitri Sivanich <sivanich@hpe.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Vasant Hegde <vasant.hegde@amd.com>, Yi Zhang <yi.zhang@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>,
        linux-block <linux-block@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>
Subject: Re: [bug report][regression] blktests block/008 lead kerne panic at
 RIP: 0010:amd_iommu_enable_faulting+0x0/0x10
Message-ID: <ZlckXh4rZ+sWRqXR@hpe.com>
References: <CAHj4cs9KZJc6Wsp9t0fDc4fDBJB1TmwGT7-8peCGLiqW3J_Fqw@mail.gmail.com>
 <ZlVk95sNtdkzZ8bE@8bytes.org>
 <77c7eb43-2321-484d-a1bf-50ddd907db17@amd.com>
 <80ceceba-ac9c-4ab7-a0e3-bdb9336a86e6@amd.com>
 <CAHj4cs9W=OEZTPqi6jx4Hinebz8VCJBpngHnr5LO-+xqWMrG2g@mail.gmail.com>
 <f9252410-a295-4ad5-9925-228119011539@amd.com>
 <BN9PR11MB5276CBD826F1E95D28B2E30A8CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <BN9PR11MB5276CBD826F1E95D28B2E30A8CF22@BN9PR11MB5276.namprd11.prod.outlook.com>
X-Proofpoint-ORIG-GUID: 5wU5SyHn4ZLuUtk0lOH_FE5JDykRFw2I
X-Proofpoint-GUID: 5wU5SyHn4ZLuUtk0lOH_FE5JDykRFw2I
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-29_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 impostorscore=0
 mlxscore=0 clxscore=1011 priorityscore=1501 phishscore=0 adultscore=0
 mlxlogscore=871 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290087

On Wed, May 29, 2024 at 08:13:42AM +0000, Tian, Kevin wrote:
> > From: Vasant Hegde <vasant.hegde@amd.com>
> > Sent: Wednesday, May 29, 2024 2:26 PM
> > 
> > Hi Yi,
> > 
> > +Dimitri, Lu, Tian.
> > 
> > 
> > On 5/29/2024 11:46 AM, Yi Zhang wrote:
> > > On Wed, May 29, 2024 at 1:40 AM Vasant Hegde <vasant.hegde@amd.com>
> > wrote:
> > >>
> > >> Hi Yi,
> > >>
> > >>
> > >> On 5/28/2024 11:00 PM, Vasant Hegde wrote:
> > >>> Hi Yi,
> > >>>
> > >>>
> > >>> On 5/28/2024 10:30 AM, Joerg Roedel wrote:
> > >>>> Adding Vasant.
> > >>>>
> > >>>> On Tue, May 28, 2024 at 10:23:10AM +0800, Yi Zhang wrote:
> > >>>>> Hello
> > >>>>> I found this regression panic issue on the latest 6.10-rc1 and it
> > >>>>> cannot be reproduced on 6.9, please help check and let me know if
> > you
> > >>>>> need any info/testing for it, thanks.
> > >>>
> > >>> I have tried to reproduce this issue on my system. So far I am not able to
> > >>> reproduce it.
> > >>>
> > >>> Will you be able to bisect the kernel?
> > >>
> > >> I see that below patch touched this code path. Can you revert below patch
> > and
> > >> test it again?
> > >
> > > Yes, the panic cannot be reproduced now after revert this patch.
> > 
> > Thanks for verifying. AMD code path (amd_iommu_enable_faulting()) just
> > return
> > zero. It doesn't do anything else. I am not familiar with cpuhp_setup_state()
> > code path.
> > 
> > @Dimitri, Can you look into this issue?
> > 
> 
> -int __init amd_iommu_enable_faulting(void)
> +int __init amd_iommu_enable_faulting(unsigned int cpu)
> 
> likely it's due to '__init' not being removed...

Yes, agreed.  I will submit a patch with this change soon.

